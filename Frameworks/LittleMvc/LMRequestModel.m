//
//  LMRequestModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-3.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMRequestModel.h"

@implementation LMRequestModel

- (void)requestDidStartLoad {

    [self didStartLoad];
}



- (void)requestDidFinishLoad {
    [self didFinishLoad];
}



- (void) requestdidFailLoadWithError:(NSError*)error {
    [self didFailLoadWithError:error];
}




@end
