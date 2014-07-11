//
//  LMDataBaseModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-8.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMDataBaseModel.h"

@implementation LMDataBaseModel

@synthesize method = _method;
-(void)dataBaseDidFinishLoad{
    
    [self didFinishLoad];
}

-(void)dataBaseDidStartLoad{
    
    [self didStartLoad];
    
}

-(void)dataBaseDidFailLoadWithError{
    [self didFailLoadWithError:nil];
}
@end
