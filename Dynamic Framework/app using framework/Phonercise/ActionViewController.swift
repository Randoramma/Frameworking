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
import CoreMotion
import ThreeRingControl

private let oneCircleLength = 30.0 // 30s to fill a circle
private let scanInterval = 0.5 // check each 1/2 second

extension ThreeRingView {
  var move: CGFloat {
    get { return innerRingValue }
    set { innerRingValue = newValue }
  }
  var exercise: CGFloat {
    get { return middleRingValue }
    set { middleRingValue = newValue }
  }
  var stand: CGFloat {
    get { return outerRingValue }
    set { outerRingValue = newValue }
  }
}

class ActionViewController: UIViewController {

  @IBOutlet weak var ringControl: ThreeRingView!
  var shakeStart: Date?
  var manager = CMMotionManager()


  override func canBecomeFirstResponder() -> Bool {
    return true
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    Fanfare.sharedInstance.playSoundsWhenReady()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    becomeFirstResponder()

    manager.deviceMotionUpdateInterval = scanInterval
    manager.startDeviceMotionUpdates(to: OperationQueue.main()) { motion, error in
      if let upright = motion?.attitude.pitch where upright > M_PI_2 * 0.75 {
        self.ringControl.stand += CGFloat(1.0 / (oneCircleLength / scanInterval))
      }
      if let rotationRate = motion?.rotationRate {
        let x = abs(rotationRate.x), y = abs(rotationRate.y), z = abs(rotationRate.z)
        if x > 0.5 || y > 0.5 || z > 0.5 {
          self.ringControl.move += CGFloat(1.0 / (oneCircleLength / scanInterval))
        }
      }
    }
  }

  override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
    if motion == .motionShake {
      shakeStart = Date()
    }
  }

  override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
    if motion == .motionShake {
      let shakeEnd = Date()
      #if (arch(i386) || arch(x86_64)) && os(iOS)
        //Test on the simulator with a simple gesture action
        let diff = 2.0
      #else
        let diff = shakeEnd.timeIntervalSinceDate(shakeStart!)
      #endif
      shake(diff)
    }
  }

  func shake(_ forNSeconds: TimeInterval) {
    self.ringControl.exercise += CGFloat(forNSeconds / oneCircleLength)
  }


}

