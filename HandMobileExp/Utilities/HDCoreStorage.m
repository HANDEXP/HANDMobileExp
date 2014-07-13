//
//  HDCoreStorage.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-1.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "HDCoreStorage.h"
#import "FMDatabase.h"

@implementation HDCoreStorage{
    HDSQLCenter *sqlCenter;

}
@synthesize  DatabasePool;

+(id)shareStorage
{
    return [self shareObject];
}


-(id)init
{
    self = [super init];
    if (self) {
        
        DatabasePool = [[FMDatabasePool alloc] initWithPath:TTPathForDocumentsResource(@"HDMobileBusiness.db")];
        DatabasePool.maximumNumberOfDatabasesToCreate = 3;
        sqlCenter = [[HDSQLCenter alloc]init];
        
        
    }
    return self;
}


#pragma mark 方法
-(NSArray*)query:(SEL) handler conditions:(NSDictionary *) conditions{
    if ([sqlCenter respondsToSelector:handler]) {
        __block  NSMutableArray  *_DATA = [[NSMutableArray alloc]init];
        void (^doDabase)(FMDatabase *db)=^(FMDatabase *db){
            FMResultSet *rs=[sqlCenter performSelector:handler withObject:db withObject:conditions];
            while ([rs next]){
                [_DATA addObject:[rs resultDictionary]];
            }
        };
        [DatabasePool inDatabase:doDabase];
        return _DATA;
    }
    NSLog(@"无效的selector:%@",NSStringFromSelector(handler));
    return nil;
}

-(BOOL)excute:(SEL) handler recordList:(NSArray *) recordList{
    if ([sqlCenter respondsToSelector:handler]) {
        __block  BOOL state = FALSE;
        void (^doDabase)(FMDatabase *db)=^(FMDatabase *db){
            state=(BOOL)[sqlCenter performSelector:handler withObject:db withObject:recordList];
        };
        [DatabasePool inDatabase:doDabase];
        return state;
    }
    NSLog(@"无效的selector:%@",NSStringFromSelector(handler));
    return NO;
}

@end
