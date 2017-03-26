//
//  Bar.swift
//  Foo
//
//  Created by Daniel Eggert on 09/01/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit
import FooPrivates



@objc(Bar)
open class Bar: NSObject {
   
    open func doSomething() {
        // We can access Baz, which is public:
        let b = Baz()
        print("\(b)")
        
        // We can also access Norf, even though it is not public:
        let n = Norf()
        print("\(n)")
        
        let q = Qux()
        print("\(q)")
    }
}
