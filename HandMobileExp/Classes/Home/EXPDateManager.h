//
//  EXPDateManager.h
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-23.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXPDateManager : NSObject

- (NSString *)getToday;
- (NSString *)getFirstDayOfThisMonth;
- (NSString *)getFirstDayOfThisWeek;

-(NSString *)getLastDayOfThisMonth;
-(NSString *)getLastDayOfThisWeek;
@end
