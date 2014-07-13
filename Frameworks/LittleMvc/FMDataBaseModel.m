//
//  FMDataBaseModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-8.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "FMDataBaseModel.h"

@implementation FMDataBaseModel
-(id)init{
    self =[super init];
    if(self){
           self.hd = [HDCoreStorage shareStorage];
        
    }
    return  self;
}

-(NSNumber *)getPrimaryKey:(NSString *)tableName
{
    FMDatabasePool *DatabasePool = self.hd.DatabasePool;
    NSString * sql =[@"SELECT max(id) as id from  " stringByAppendingString:tableName];
    


     NSMutableArray  *  DATA = [[NSMutableArray alloc]init];
    void (^doDabase)(FMDatabase *db)=^(FMDatabase *db){
        
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]){
            [DATA addObject:[rs resultDictionary]];

      
        }
        
    };
    [DatabasePool inDatabase:doDabase];
    NSNumber * num = [[DATA objectAtIndex:0]valueForKey:@"id"];
    NSLog(@"%d",[num intValue]);
    return num;

    
}

-(void)loadMethod:(NSString *)method
            param:(id)param
           excute:(SEL) handler{
    self.method = method;

        [self dataBaseDidStartLoad];
    if([method isEqualToString:@"insert"]){
        
        if([self.hd excute:handler recordList:param]){
            [self dataBaseDidFinishLoad];
        }else{
            [self dataBaseDidFailLoadWithError];
        }
        
    }else if([method isEqualToString:@"update"] ){
        
        [self.hd excute:handler recordList:param];
        [self dataBaseDidFinishLoad];
        
        
    }else if([method isEqualToString:@"delete"]){
        
        [self.hd excute:handler recordList:param];
        [self dataBaseDidFinishLoad];
        
    }else if([method isEqualToString:@"query"]){
        
        self.result = [self.hd query:handler
                                                     conditions:param];
        
        [self dataBaseDidFinishLoad];
        
    }else{
        
        NSLog(@"unsupport method");
    }
    
    
    
    
}
@end
