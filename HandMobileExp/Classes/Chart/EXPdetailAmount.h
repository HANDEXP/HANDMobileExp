//
//  EXPdetailAmount.h
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-29.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXPdetailAmount : NSObject

@property (nonatomic, strong) NSString *year;

@property (nonatomic, strong) NSString *month;

@property (nonatomic) float sumAmount;

@property (nonatomic, strong) NSString *type;

- (float)getSumAmountWithYear: (NSString *)year Month: (NSString *)month;

- (id)initWithYear: (NSString *)year Month: (NSString *)month SumAmount: (float)sumAmount Type: (NSString *) type;

- (float)getSumAmountWithYear: (NSString *)year Month: (NSString *)month Type: (NSString *)type;


@end
