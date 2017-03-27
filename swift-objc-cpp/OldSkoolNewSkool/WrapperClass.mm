//
//  WrapperClass.m
//  OldSkoolNewSkool
//
//  Created by Randy McLain on 3/26/17.
//  Copyright © 2017 Randy McLain. All rights reserved.
//

#import "WrapperClass.h"
#include "Cube.h"

@interface WrapperClass()
    
    @property (nonatomic, assign) Cube myCube;

@end

@implementation WrapperClass

    -(bool) makeACubeWithSidesOfLength:(double)sidelength {
        Cube myCube = *new Cube();
        myCube.setSide(sidelength);
            return [self sideLengthGreaterThanZero:[self getSideForCube:myCube]];
    }
    
    -(double) getSideForCube:(Cube )theCube {
        return theCube.getSide();
    }
    
    -(bool) sideLengthGreaterThanZero:(double)sideLength {
        return sideLength > 0;
    }
    
@end
