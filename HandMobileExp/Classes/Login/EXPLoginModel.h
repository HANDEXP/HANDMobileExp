//
//  EXPLoginModel.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-3.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "AFNetRequestModel.h"
#import "EXPApplicationContext.h"

@interface EXPLoginModel :AFNetRequestModel
- (void)load:(int)cachePolicy more:(BOOL)more;
- (void)load:(NSDictionary *)param;


-(void)loadExpenseType;
@end
