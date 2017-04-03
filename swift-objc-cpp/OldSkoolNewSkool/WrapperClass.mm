//
//  WrapperClass.m
//  OldSkoolNewSkool
//
//  Created by Randy McLain on 3/26/17.
//  Copyright © 2017 Randy McLain. All rights reserved.
//

#import "WrapperClass.h"
#import "RString.h"


@interface WrapperClass()
@property (nonatomic, assign) RString::RString * myStringChanger;

@end

@implementation WrapperClass


+(bool) containsCharacters:(NSString* )queryString InString:(NSString *)theString {
    
    std::string bar = std::string([queryString UTF8String]);
    std::string foo = std::string([theString UTF8String]);
    return RString::RString::contains(bar, foo);
    
}

+(NSString *) replaceString:(NSString *)outString withString:(NSString *)inString insideString:(NSString *)queryString {
    
    std::string stdstringin = std::string([inString UTF8String]);
    std::string stdstringout = std::string([outString UTF8String]);
    std::string stdstrinq = std::string([queryString UTF8String]);
    
    NSString*  returnString = [NSString stringWithUTF8String:stdstrinq.c_str()];
    return returnString; 
}



    
@end
