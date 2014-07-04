//
//  AFNetRequestModel.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-3.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMRequestModel.h"
#import "EXPAFNetWorkingUtil.h"

@interface AFNetRequestModel : LMRequestModel
@property(strong) NSMutableArray * Json;
@property(strong) NSError   *error;


-(void)request:(NSString *)method
         param:(NSDictionary *)param
           url:(NSString *)url;
@end
