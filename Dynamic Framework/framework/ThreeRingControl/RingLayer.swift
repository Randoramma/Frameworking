/*
* Copyright (c) 2016 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class RingLayer : CALayer {

  fileprivate let angleOffsetForZero = CGFloat(-M_PI_2)
  fileprivate lazy var gradientLayer : CircularGradientLayer = {
    let gradLayer = CircularGradientLayer()
    gradLayer.colors = self.ringColors
    return gradLayer
  }()

  fileprivate lazy var backgroundLayer : CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.strokeColor = self.ringBackgroundColor
    layer.lineWidth = self.ringWidth
    layer.fillColor = nil
    return layer
  }()

  fileprivate lazy var foregroundLayer : CALayer = {
    let layer = CALayer()
    layer.addSublayer(self.gradientLayer)
    layer.mask = self.foregroundMask
    return layer
  }()

  fileprivate lazy var ringTipLayer : RingTip = {
    let layer = RingTip()
    layer.color = self.ringColors.0
    layer.ringWidth = self.ringWidth
    return layer
  }()

  fileprivate lazy var foregroundMask : CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.strokeColor = UIColor.black.cgColor
    layer.fillColor = UIColor.clear.cgColor
    layer.lineWidth = self.ringWidth
    layer.lineCap = kCALineCapRound
    return layer
  }()


  //:- Public API
  var ringWidth: CGFloat = 40.0 {
    didSet {
      backgroundLayer.lineWidth = ringWidth
      ringTipLayer.ringWidth = ringWidth
      foregroundMask.lineWidth = ringWidth
      preparePaths()
    }
  }
  fileprivate var _value: CGFloat = 0.0
  var value: CGFloat {
    get {
      return _value
    }
    set(newValue) {
      setValue(newValue, animated: false)
    }
  }
  var ringColors: (CGColor, CGColor) = (UIColor.red.cgColor, UIColor.red.darkerColor.cgColor) {
    didSet {
      gradientLayer.colors = ringColors
      ringTipLayer.color = ringColors.0
    }
  }
  var ringBackgroundColor: CGColor = UIColor.darkGray.cgColor {
    didSet {
      backgroundLayer.strokeColor = ringBackgroundColor
    }
  }

  //:- Initialisation
  override init() {
    super.init()
    sharedInitialization()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInitialization()
  }

  override init(layer: Any) {
    super.init(layer: layer)
    if let layer = layer as? RingLayer {
      ringWidth = layer.ringWidth
      value = layer.value
      ringBackgroundColor = layer.ringBackgroundColor
      ringColors = layer.ringColors
    }
  }
}

extension RingLayer {
  fileprivate func sharedInitialization() {
    backgroundColor = UIColor.black.cgColor
    [backgroundLayer, foregroundLayer, ringTipLayer].forEach { self.addSublayer($0) }
    self.value = 0.8
  }

  override func layoutSublayers() {
    super.layoutSublayers()
    if backgroundLayer.bounds != bounds {
      for layer in [backgroundLayer, foregroundLayer, foregroundMask, gradientLayer, ringTipLayer] {
        layer.bounds = bounds
        layer.position = center
      }
      preparePaths()
    }
  }
}

extension RingLayer {
  fileprivate var radius : CGFloat {
    return (min(bounds.width, bounds.height) - ringWidth) / 2.0
  }

  fileprivate func preparePaths() {
    backgroundLayer.path = backgroundPath
    foregroundMask.path = maskPathForValue(value)
  }

  fileprivate var backgroundPath : CGPath {
    return UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true).cgPath
  }

  fileprivate func maskPathForValue(_ value: CGFloat) -> CGPath {
    return UIBezierPath(arcCenter: center, radius: radius, startAngle: angleOffsetForZero, endAngle: angleForValue(value), clockwise: true).cgPath
  }

  fileprivate func angleForValue(_ value: CGFloat) -> CGFloat {
    return value * 2 * CGFloat(M_PI) + angleOffsetForZero
  }
}

extension RingLayer {
  func setValue(_ value: CGFloat, animated: Bool = false) {
    if animated {
      animateFromValue(_value, toValue: value)
    } else {
      CATransaction.begin()
      CATransaction.setDisableActions(true)
      foregroundMask.path = maskPathForValue(value)
      ringTipLayer.setValue(angleForValue(value), forKeyPath: "transform.rotation.z")
      gradientLayer.setValue(angleForValue(value), forKeyPath: "transform.rotation.z")
      CATransaction.commit()
    }

    _value = value
  }

  fileprivate func animateFromValue(_ fromValue: CGFloat, toValue: CGFloat) {
    let angleDelta = (toValue - fromValue) * 2.0 * CGFloat(M_PI)
    if abs(angleDelta) < 0.001 {
      return
    }

    CATransaction.begin()
    CATransaction.setDisableActions(true)
    CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))

    // Rotate the tip and the gradient
    ringTipLayer.add(rotationForLayer(ringTipLayer, byAngle: angleDelta), forKey: "transform.rotation.z")
    gradientLayer.add(rotationForLayer(gradientLayer, byAngle: angleDelta), forKey: "transform.rotation.z")
    // Update model
    ringTipLayer.setValue(angleForValue(toValue), forKeyPath: "transform.rotation.z")
    gradientLayer.setValue(angleForValue(toValue), forKeyPath: "transform.rotation.z")

    // Update the foreground mask path
    let finalMaskPath = maskPathForValue(toValue)
    let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
    if angleDelta > 0 {
      // Need to grow the mask. Immediately create the larger path and animate strokeEnd to fill it
      foregroundMask.path = finalMaskPath
      strokeAnimation.fromValue = fromValue / toValue
      strokeAnimation.toValue = 1.0
    } else {
      // Mask needs to shrink. Animate down and replace mask at end of transaction
      strokeAnimation.fromValue = 1.0
      strokeAnimation.toValue = toValue / fromValue
      CATransaction.setCompletionBlock {
        // Update the mask to the new shape after the animation
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.foregroundMask.path = finalMaskPath
        self.foregroundMask.strokeEnd = 1.0
        CATransaction.commit()
      }
    }
    foregroundMask.add(strokeAnimation, forKey: "strokeEnd")

    CATransaction.commit()
  }
}






