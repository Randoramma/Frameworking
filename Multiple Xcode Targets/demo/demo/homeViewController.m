//
//  ViewController.m
//  demo
//
//  Created by Luis Castillo on 7/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "homeViewController.h"

@interface homeViewController ()

@end

@implementation homeViewController


#pragma mark - Views
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}//eom

-(void)viewDidAppear:(BOOL)animated
{
    //checking c flags here
    #ifdef DVERSION
        [self showMessage:@"You are running demo_V1" withTitle:@"demo_V1"];
    #else
        //nothing to do
        [self showMessage:@"You are running demo" withTitle:@"demo"];
    #endif
}//eom


#pragma mark - Print Message
-(void)showMessage:(NSString *)message withTitle:(NSString *)title
{
    UIAlertController * alertCont = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    
    [alertCont addAction:okay];
    
    [self presentViewController:alertCont animated:true completion:nil];
    
}//eom

#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
