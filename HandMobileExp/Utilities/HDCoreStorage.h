//
//  HDCoreStorage.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-1.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDSingletonObject.h"
#import "HDSQLCenter.h"
#import "EXPApplicationContext.h"
@interface HDCoreStorage : HDSingletonObject

+(id)shareStorage;

-(NSArray*)query:(SEL) handler conditions:(NSDictionary *) conditions;

-(BOOL)excute:(SEL) handler recordList:(NSArray *) recordList;
@end
