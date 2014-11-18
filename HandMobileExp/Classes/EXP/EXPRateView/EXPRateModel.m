//
//  EXPRateModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-11-17.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPRateModel.h"
#import "EXPApplicationContext.h"

@implementation EXPRateModel

-(BOOL)autoLoaded{
    return NO;
    
}

-(void)load
{
    
       [self request:@"GET" param:nil url:[[EXPApplicationContext shareObject] keyforUrl:@"exchange_rate_url" ]];
    
}



@end





