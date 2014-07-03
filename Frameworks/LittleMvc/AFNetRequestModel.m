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
        self.item = [[NSMutableArray alloc] init];
        
    }
    return self;
}

-(void)request:(NSString *)method
         param:(NSDictionary *)param
           url:(NSString *)url{
    
    EXPAFNetWorkingUtil * afUtl = [EXPAFNetWorkingUtil shareObject];
    
    [self didStartLoad];
    
    if(![method compare: @"GET"]){
        [afUtl getsuccess:^(id Json){
            NSLog(@"%@",[NSString stringWithUTF8String:object_getClassName(Json)]);
            NSDictionary * ns =  [ Json  valueForKey:@"error"];
            NSLog(@"%@",[ns  valueForKey:@"message"]);
            [self didFinishLoad];
        }geterror:^(NSError *error){
            
            [self didFailLoadWithError:error];
        }param:param url:url];
        
    }else if (![method compare: @"POST"]){
         
        [afUtl postsuccess:^(id Json) {
            [self didFinishLoad];
        
        }posterror:^(NSError *error){
             [self didFailLoadWithError:error];
        
        }param:param url:url];
        
        
    }else{
        
        NSLog(@"UNSUPPORT REQUEST METHOD");
    }
    
    
    
    
}

@end
