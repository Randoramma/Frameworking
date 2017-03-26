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

class RingTip : CALayer {
  
  //MARK:- Constituent Layers
  fileprivate lazy var tipLayer : CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.lineCap = kCALineCapRound
    layer.lineWidth = self.ringWidth
    return layer
    }()
  
  fileprivate lazy var shadowLayer : CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.lineCap = kCALineCapRound
    layer.strokeColor = UIColor.black.cgColor
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = .zero
    layer.shadowRadius = 12.0
    layer.shadowOpacity = 1.0
    layer.mask = self.shadowMaskLayer
    return layer
    }()
  
  fileprivate lazy var shadowMaskLayer : CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.strokeColor = UIColor.black.cgColor
    layer.lineCap = kCALineCapButt
    return layer
    }()
  
  //MARK:- Utility Properties
  fileprivate var radius : CGFloat {
    return (min(bounds.width, bounds.height) - ringWidth) / 2.0
  }
  
  fileprivate var tipPath : CGPath {
    return UIBezierPath(arcCenter: center, radius: radius, startAngle: -0.01, endAngle: 0, clockwise: true).cgPath
  }
  
  fileprivate var shadowMaskPath : CGPath {
    return UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true).cgPath
  }
  
  //MARK:- API Properties
  var color: CGColor = UIColor.red.cgColor {
    didSet {
      tipLayer.strokeColor = color
    }
  }
  
  var ringWidth: CGFloat = 40.0 {
    didSet {
      tipLayer.lineWidth = ringWidth
      shadowLayer.lineWidth = ringWidth
      shadowMaskLayer.lineWidth = ringWidth
      preparePaths()
    }
  }
  
  //MARK:- Initialisation
  override init() {
    super.init()
    sharedInitialisation()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInitialisation()
  }
  
  override init(layer: Any) {
    super.init(layer: layer)
    if let layer = layer as? RingTip {
      color = layer.color
      ringWidth = layer.ringWidth
    }
  }
  
  
  fileprivate func sharedInitialisation() {
    addSublayer(shadowLayer)
    addSublayer(tipLayer)
    color = UIColor.red.cgColor
    preparePaths()
  }
  
  //MARK:- Lifecycle Overrides
  override func layoutSublayers() {
    for layer in [tipLayer, shadowLayer, shadowMaskLayer] {
      layer.bounds = bounds
      layer.position = center
    }
    preparePaths()
  }
  
  //MARK:- Utility methods
  fileprivate func preparePaths() {
    tipLayer.path = tipPath
    shadowLayer.path = tipPath
    shadowMaskLayer.path = shadowMaskPath
  }
}
