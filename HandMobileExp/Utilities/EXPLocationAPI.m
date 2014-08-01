//
//  EXPLocationAPI.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-21.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPLocationAPI.h"
#import "EXPLocationManager.h"

@interface EXPLocationAPI ()
{
    EXPLocationManager *locationManager;
}

@end

@implementation EXPLocationAPI

//- (void)setCity:(NSString *)city
//{
//    if (!city) {
//        city = @"";
//    }
//}

+ (EXPLocationAPI *)shareInstance
{
    static EXPLocationAPI *_shareInstance = nil;
    static dispatch_once_t onePredicate;
    
    dispatch_once(&onePredicate, ^{
        _shareInstance = [[EXPLocationAPI alloc]init];
    });
    
    return _shareInstance;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        locationManager = [[EXPLocationManager alloc]init];
    }
    return self;
}

- (NSString *)getCity
{
    return [locationManager getCity];
}

- (NSString *)getProvince
{
    return [locationManager getProvince];
}


@end
