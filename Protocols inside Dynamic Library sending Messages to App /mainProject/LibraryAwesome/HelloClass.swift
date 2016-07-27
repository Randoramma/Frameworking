//
//  HelloClass.swift
//  mainProject
//
//  Created by Luis Castillo on 7/27/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation


@objc public protocol HelloDelegate {
    func HelloResponder_message(message:NSString)
}


@objc public class HelloClass:NSObject {
    
    
    public var delegate:HelloDelegate?
    
    public func sendMeAMessage()
    {
        let message = "Message from Dynamic Framework"
        delegate?.HelloResponder_message(message)
    }//eom
    
}//eoc