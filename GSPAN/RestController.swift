//
//  RestController.swift
//  Frameworking
//
//  Created by Randy McLain on 5/5/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

import UIKit

@objc
class RestController: NSObject {
  
  
  static let sharedController = RestController()
  
  
  var numberOfAwesome : Int = 0; 
  
  
  func thisTotoallyWorked () {
    
    print("This totally worked!")
    
  }
  
  
  
}