//
//  EXPLineDetailModel.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-10.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "FMDataBaseModel.h"

@interface EXPLineDetailModel : FMDataBaseModel
-(void)save:(NSDictionary *)param;
-(void)update:(NSArray *)param;
@end
