//
//  ViewController.swift
//  OldSkoolNewSkoolDemo
//
//  Created by Randy McLain on 4/2/17.
//  Copyright © 2017 Randy McLain. All rights reserved.
//

import UIKit
import OldSkoolNewSkool

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I know this isnt doing anything, but the important thing here is that the swift 
        WrapperClass.containsCharacters("this is a string", in: "OMG I cant believe the modules are talking and this is a string")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

