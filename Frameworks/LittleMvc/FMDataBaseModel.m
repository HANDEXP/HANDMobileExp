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



-(void)loadMethod:(NSString *)method
            param:(id)param
           excute:(SEL) handler{
    self.method = method;

        [self dataBaseDidStartLoad];
    if([method isEqualToString:@"insert"]){
        
        [self.hd excute:handler recordList:param];
        [self dataBaseDidFinishLoad];
        
    }else if([method isEqualToString:@"update"] ){
        
        [self.hd excute:handler recordList:param];
        [self dataBaseDidFinishLoad];
        
        
    }else if([method isEqualToString:@"delete"]){
        
        [self.hd excute:handler recordList:param];
        [self dataBaseDidFinishLoad];
        
    }else if([method isEqualToString:@"query"]){
        
        self.result = [[HDCoreStorage shareStorage] query:@selector(QUERY_MOBILE_EXP_REPORT_HEADER:)
                                                     conditions:param];
        
        [self dataBaseDidFinishLoad];
        
    }else{
        
        NSLog(@"unsupport method");
    }
    
    
    
    
}
@end
