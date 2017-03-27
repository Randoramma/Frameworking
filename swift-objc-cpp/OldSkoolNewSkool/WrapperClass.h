//
//  WrapperClass.h
//  OldSkoolNewSkool
//
//  Created by Randy McLain on 3/26/17.
//  Copyright © 2017 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WrapperClass : NSObject

    /* Its important not to put references to any objects or methods found within the c++ file into this header class.  
     For this to be a true wrapper class it must have only objective-c code and no connection to the c++ classes.  Otherwise
     you will have to persist the objective-c++ implementation files to classes importing this one. This way this class
     can interact with objective-c and swift just as if it were a true objective-c class.
     */
    
    
    -(bool) makeACubeWithSidesOfLength:(double)sidelength;
    -(double) getVolumeForCube();
@end
