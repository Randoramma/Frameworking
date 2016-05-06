//
//  ViewController.m
//  Frameworking
//
//  Created by Randy McLain on 5/5/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "ViewController.h"
#import "Frameworking-Swift.h"
//#include "GSPAN.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)segmentedSelected:(id)sender {
  [[RestController sharedController] thisReallyTotoallyWorked]; 
}

- (IBAction)buttonPressed:(id)sender {


  [[Test sharedTest] thisTotallyWorked];
  [[RestController sharedController] thisReallyTotoallyWorked];
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
