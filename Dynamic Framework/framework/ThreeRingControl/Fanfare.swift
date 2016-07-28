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


import Foundation
import AVFoundation

public class Fanfare {
  public var ringSound = "coin07"
  public var allRingSound = "winning"

  public static let sharedInstance = Fanfare()

  private var player: AVAudioPlayer?

  public func playSoundsWhenReady() {
    NotificationCenter.default().addObserver(forName: NSNotification.Name(rawValue: RingCompletedNotification), object: nil, queue: OperationQueue.main()) { _ in
      self.playSound(self.ringSound)
    }
    NotificationCenter.default().addObserver(forName: NSNotification.Name(rawValue: AllRingsCompletedNotification), object: nil, queue: OperationQueue.main()) { _ in
      self.playSound(self.allRingSound)
    }
  }

  private func playSound(_ sound: String) {
    if let url = Bundle(for: self.dynamicType).urlForResource(sound, withExtension: "mp3") {
      player = try? AVAudioPlayer(contentsOf: url)
      if player != nil {
        player!.numberOfLoops = 0
        player!.prepareToPlay()
        player!.play()
      }
    }
  }

  deinit {
    NotificationCenter.default().removeObserver(self)
  }
}
