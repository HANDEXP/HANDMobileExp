//
//  EXPdetailAmount.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-29.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPdetailAmount.h"

@implementation EXPdetailAmount

- (float)getSumAmountWithYear: (NSString *)year Month: (NSString *)month
{
    if ([self.year isEqualToString:year] && [self.month isEqualToString:month]) {
        return self.sumAmount;
    }
    
    return 0;
}

- (float)getSumAmountWithYear: (NSString *)year Month: (NSString *)month Type: (NSString *)type
{
    if ([self.year isEqualToString:year] && [self.month isEqualToString:month] && [self.type isEqualToString:type]) {
        return self.sumAmount;
    }
    
    return 0;
}

- (id)initWithYear: (NSString *)year Month: (NSString *)month SumAmount: (float) sumAmount Type:(NSString *)type
{
    self = [super init];
    
    if (self) {
        self.year = year;
        self.month = month;
        self.sumAmount = sumAmount;
        self.type = type;
    }
    
    return self;
}

@end
