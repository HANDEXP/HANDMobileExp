//
//  EXPDataSettingModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-30.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPDataSettingModel.h"
#import "EXPApplicationContext.h"

@implementation EXPDataSettingModel


-(void)loadExpenseClass{
    
    [self request:@"GET" param:nil url:[[EXPApplicationContext shareObject] keyforUrl:@"synchronization_url" ]];
    
}
@end
