//
//  Cube.m
//  OldSkoolNewSkool
//
//  Created by Randy McLain on 3/26/17.
//  Copyright © 2017 Randy McLain. All rights reserved.
//

#include <iostream>
#include "Cube.h"

Cube::Cube(std::string id) {

}

Cube::~Cube(){

}

void Cube::setSide(double s){
    Side = s <= 0 ? 1 : s;

}

double Cube::getSide(){
    
    return Side;
}

double Cube::Area(){
    return 6 * Side * Side;

}

double Cube::Volume(){
    return Side * Side * Side;

}

void Cube::Properties(){
    std::cout << "Characteristics of this cube";
    std::cout << "\nSide   = " << getSide();
    std::cout << "\nArea   = " << Area();
    std::cout << "\nVolume = " << Volume() << "\n\n";
}


