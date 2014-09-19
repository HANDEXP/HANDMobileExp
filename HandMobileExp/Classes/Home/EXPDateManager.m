//
//  EXPDateManager.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-23.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPDateManager.h"

@interface EXPDateManager ()
{
    NSDate *nowDate;
    NSDateFormatter *dateFormatter;
    
    NSCalendar *calendar;
}
@end

@implementation EXPDateManager

- (id)init
{
    self = [super init];
    if (self) {
        nowDate = [NSDate dateWithTimeIntervalSinceNow:0.0];
        calendar = [NSCalendar currentCalendar];
        [calendar setFirstWeekday:2];
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return self;
}



- (NSString *)getToday
{
    NSString *nowDateStr = [dateFormatter stringFromDate:nowDate];
    return nowDateStr;
}

- (NSString *)getFirstDayOfThisMonth
{
    
    NSDate *beginDate = nil;
    double interval = 0;
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:nowDate];
    if (ok) {   
        NSString *nowDateStr = [dateFormatter stringFromDate:beginDate];
        return nowDateStr;
    }else
        return @"";
}

- (NSString *)getFirstDayOfThisWeek
{
    
    
    NSDate *beginDate = nil;
    double interval = 0;
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:nowDate];
    if (ok) {
        NSString *nowDateStr = [dateFormatter stringFromDate:beginDate];
        return nowDateStr;
    }else
        return @"";
}

@end
