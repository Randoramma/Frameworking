//
//  Cube.h
//  OldSkoolNewSkool
//
//  Created by Randy McLain on 3/26/17.
//  Copyright © 2017 Randy McLain. All rights reserved.
//

#ifndef CUBE_H

#define CUBE_H

class Cube {
    
    public:	Cube:();
    
    ~Cube();
    void setSide(double s);
    double getSide();
    double Area();
    double Volume();
    
    void Properties();
    
    private:
    double Side;
};

#endif
