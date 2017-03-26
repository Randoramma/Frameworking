//
//  Test.swift
//  Frameworking
//
//  Created by Randy McLain on 5/5/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

import UIKit

@objc
class Test: NSObject {
  
  static let sharedTest = Test()
  
  
  func thisTotallyWorked () {
    
    print("This totally worked ... now for the framework!!")
    
  }
  
  
}