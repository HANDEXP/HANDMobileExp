//
//  LMRequestModel.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-3.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMModel.h"

@interface LMRequestModel : LMModel

- (void)requestDidStartLoad ;
- (void)requestDidFinishLoad;
- (void) requestdidFailLoadWithError:(NSError*)error;

@end
