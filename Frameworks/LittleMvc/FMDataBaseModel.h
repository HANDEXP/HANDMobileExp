//
//  FMDataBaseModel.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-8.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMDataBaseModel.h"
#import "HDCoreStorage.h"

@interface FMDataBaseModel : LMDataBaseModel

@property(strong) HDCoreStorage * hd;
@property(strong) NSArray *result;
-(void)loadMethod:(NSString *)method
            param:(NSDictionary *)param
           excute:(SEL) handler;

-(NSNumber *)getPrimaryKey:(NSString *)tableName;
@end
