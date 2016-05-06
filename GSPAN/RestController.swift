//
//  RestController.swift
//  Frameworking
//
//  Created by Randy McLain on 5/5/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

import UIKit

@objc
public class RestController: NSObject {
  
  
  public static let sharedController = RestController()
  
  
  var numberOfAwesome : Int = 0; 
  
  
  public func thisReallyTotoallyWorked () {
    
    print("This totally worked, you just linked a Swift Module to an Objective C project!!")
    
  }
  
  
  
}