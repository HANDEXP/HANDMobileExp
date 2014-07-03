//
//  EXPLoginModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-3.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPLoginModel.h"

@implementation EXPLoginModel

-(id)init{
    self = [super init];
    if(self){
        
        
        
    }
    
    return self;
}

-(void)load{
    [self request:@"POST" param:nil url:@"modules/mobile_um/client/commons/function_center/function_query.svc"];
    
    
}


@end
