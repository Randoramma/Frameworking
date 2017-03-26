//
//  HelloClass.swift
//  mainProject
//
//  Created by Luis Castillo on 7/27/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation


@objc public protocol HelloDelegate {
    func HelloResponder_message(_ message:NSString)
}


@objc open class HelloClass:NSObject {
    
    
    open var delegate:HelloDelegate?
    
    open func sendMeAMessage()
    {
        let message = "Message from Dynamic Framework"
        delegate?.HelloResponder_message(message as NSString)
    }//eom
    
}//eoc
