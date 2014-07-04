//
//  EXPSingleMap.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-1.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "HDSingletonObject.h"
static NSMutableDictionary *_gSingletonMap;

@implementation HDSingletonObject

+(id)shareObject
{
    if(_gSingletonMap ==nil){
        _gSingletonMap = [[NSMutableDictionary alloc] init];
    };
    NSString * className = [NSString stringWithUTF8String:object_getClassName(self)];
     @synchronized(self){
     if ([_gSingletonMap valueForKey:className] == nil){
         id object = [ NSAllocateObject ([super class], 0, NULL) init] ;
         [_gSingletonMap setObject:object forKey:className];
         
     }
     }
    return [_gSingletonMap valueForKey:className];
        
}

@end
