//
//  EXPLineDetailModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-10.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPLineDetailModel.h"

@implementation EXPLineDetailModel


-(void)save:(NSArray *)param{
    [self loadMethod:@"insert" param:param excute:@selector(MOBILE_EXP_REPORT_LINE:recordList:)];
    
}

-(void)query:(NSDictionary *)condition{
    [self loadMethod:@"query" param:condition excute:@selector(QUERY_MOBILE_EXP_REPORT_LINE:)];
}
@end
