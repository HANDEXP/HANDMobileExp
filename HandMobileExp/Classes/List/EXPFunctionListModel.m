//
//  EXPFunctionListModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-5.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPFunctionListModel.h"

@implementation EXPFunctionListModel


-(id)init{
    self = [super init];
    if(self){
        
        
        
    }
    
    return self;
}
-(BOOL)autoLoaded{
    return true;
    
}

- (void)load:(int)cachePolicy more:(BOOL)more{
    
    NSLog(@"in functionlist request");
    [self request:@"GET" param:nil url:[[EXPApplicationContext shareObject] keyforUrl:@"function_query_url" ]];
    

    
}

-(void)loadExpenseClass{
    
     [self request:@"GET" param:nil url:[[EXPApplicationContext shareObject] keyforUrl:@"synchronization_url" ]];
    
}
@end
