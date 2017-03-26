//
//  ViewController.m
//  Frameworking
//
//  Created by Randy McLain on 5/5/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import "ViewController.h"
#import "Frameworking-Swift.h"
#include "GSPAN.h"


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
  [[RestController getInstance] startupServices:@"FitBit"];
}

- (IBAction)buttonPressed:(id)sender {

  [[RestController getInstance] getData:@"FitBit.steps" completion:^(NSArray<NSDictionary<NSString *,id> *> * _Nullable data, NSError * _Nullable error) {
    if (data != nil ) {
      // create an array of like 400 objects to save to core data.  
      NSMutableDictionary *stepsDict = nil;
      
      for (int i =0; i < 366; i ++ ) {
        
        int startDate = 20150101;
        int theDate = (startDate + i);
        int startStep = 0;
        int theStep = (startStep + i);
        
        NSString *dateString = [NSString stringWithFormat:@"%d", theDate];
        NSString *stepString = [NSString stringWithFormat:@"%d", theStep];
        [stepsDict setValue: stepString forKey:dateString];
      }
      
    }
  }];
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
