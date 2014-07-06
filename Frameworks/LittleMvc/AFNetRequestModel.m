//
//  AFNetRequestModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-3.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "AFNetRequestModel.h"

@implementation AFNetRequestModel
-(id)init{
    self=[super init];
    if(self){
        
        self.utl= [EXPAFNetWorkingUtil shareObject];
        

    }
    return self;
}
-(void)setValue:(NSString *)value
       forHTTPHeaderField:(NSString *)field{
    [self.utl setValue:value forHTTPHeaderField:field];

}

-(void)request:(NSString *)method
         param:(NSDictionary *)param
           url:(NSString *)url{
        [self didStartLoad];
    if(![method compare: @"GET"]){
        [self.utl getsuccess:^(id Json){
            self.Json = Json;
            [self requestDidFinishLoad];
        }geterror:^(NSError *error){
            self.error = error;
            [self requestdidFailLoadWithError:error];
        }param:param url:url];
        
    }else if (![method compare: @"POST"]){
         
        [self.utl postsuccess:^(id Json) {
            self.Json = Json;
            [self requestDidFinishLoad];
        }posterror:^(NSError *error){
             self.error = error;
            [self requestdidFailLoadWithError:error];
        
        }param:param url:url];
        
        
    }else{
        
        NSLog(@"UNSUPPORT REQUEST METHOD");
    }
    
    
    
    
}

@end
