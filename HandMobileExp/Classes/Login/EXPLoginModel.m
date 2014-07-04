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
-(BOOL)autoLoaded{
    return false;
    
}

- (void)load:(NSDictionary *)param{
    

                                   
    [self request:@"GET" param:param url:[[EXPApplicationContext shareObject] keyforUrl:@"login_submit_url" ]];
}


@end
