//
//  EXPLocationAPI.h
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-21.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXPLocationAPI : NSObject


+ (EXPLocationAPI *)shareInstance;

- (NSString *)getCity;
- (NSString *)getProvince;
@end
