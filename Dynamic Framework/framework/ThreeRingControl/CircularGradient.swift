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

import CoreImage
import UIKit


private class CircularGradientFilter : CIFilter {
  
  fileprivate lazy var kernel: CIColorKernel  = {
    return self.createKernel()
    }()
  
  var outputSize: CGSize!
  var colors: (CIColor, CIColor)!
  
  override var outputImage : CIImage {
    let dod = CGRect(origin: .zero, size: outputSize)
    let args = [ colors.0 as AnyObject, colors.1 as AnyObject, outputSize.width, outputSize.height] as [Any]
    return kernel.apply(withExtent: dod, arguments: args)!
  }
  
  fileprivate func createKernel() -> CIColorKernel {
    let kernelString =
    "kernel vec4 chromaKey( __color c1, __color c2, float width, float height ) { \n" +
      "  vec2 pos = destCoord();\n" +
      "  float x = 1.0 - 2.0 * pos.x / width;\n" +
      "  float y = 1.0 - 2.0 * pos.y / height;\n" +
      "  float prop = atan(y, x) / (3.1415926535897932 * 2.0) + 0.5;\n" +
      "  return c1 * prop + c2 * (1.0 - prop);\n" +
    "}"
    return CIColorKernel(string: kernelString)!
  }
}



class CircularGradientLayer : CALayer {
  fileprivate let gradientFilter = CircularGradientFilter()
  fileprivate let ciContext = CIContext(options: [ kCIContextUseSoftwareRenderer : false ])
  
  override init() {
    super.init()
    needsDisplayOnBoundsChange = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    needsDisplayOnBoundsChange = true
  }
  
  override init(layer: Any) {
    super.init(layer: layer)
    needsDisplayOnBoundsChange = true
    if let layer = layer as? CircularGradientLayer {
      colors = layer.colors
    }
  }
  
  var colors: (CGColor, CGColor) = (UIColor.white.cgColor, UIColor.black.cgColor) {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override func draw(in ctx: CGContext) {
    super.draw(in: ctx)
    gradientFilter.outputSize = bounds.size
    gradientFilter.colors = (CIColor(cgColor: colors.0), CIColor(cgColor: colors.1))
    let image = ciContext.createCGImage(gradientFilter.outputImage, from: bounds)
    ctx.draw(image!, in: bounds)
  }
}
