//
//  ViewController.m
//  mainProject
//
//  Created by Luis Castillo on 7/27/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "ViewController.h"
#include "LibraryAwesome.h"

@interface ViewController ()

@end

@implementation ViewController


#pragma mark View
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HelloClass * classFromLib = [[HelloClass alloc]init];
    classFromLib.delegate = self;
    [classFromLib sendMeAMessage];
}



#pragma mark delegates
-(void)HelloResponder_message:(NSString*)message
{
    NSLog(@"message received: %@", message);
}//eom



#pragma mark memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
