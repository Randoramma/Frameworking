//
//  ImportOperation.h
//  Frameworking
//
//  Created by Randy McLain on 9/12/16.
//  Copyright © 2016 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionHandler)(BOOL success, NSError *error);

@interface ImportOperation : NSOperation

@end
