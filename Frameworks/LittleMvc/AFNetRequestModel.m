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
    NSLog(@"%@",url);
        [self didStartLoad];

    if(![method compare: @"GET"]){
        
        [self.utl getsuccess:^(id JSON){
            self.Json = JSON;
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
-(void) param:(NSDictionary *)param
          url:(NSString *)url
{
    [self didStartLoad];
    
    [self.utl success:^(AFHTTPRequestOperation *operation,id responseObject){
        self.Json = responseObject;
        [self requestDidFinishLoad];
        
    }error:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.error = error;
        NSLog(@"%@",error);
        [self requestdidFailLoadWithError:error];
    } param:param url:url
        
     ];
    
    
}

////////////批量上传图片接口//////////////
-(void) uploadparam:(NSDictionary *)param
              files:(NSMutableArray *)files
        url:(NSString *)url
{
        [self didStartLoad];
    
    [self.utl success:^(AFHTTPRequestOperation *operation,id responseObject){
        self.Json = responseObject;
        [self requestDidFinishLoad];
        
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.error = error;
        NSLog(@"%@",error);
        [self requestdidFailLoadWithError:error];
    } param:param files:files url:url];
    
    
}


//////////////上传一张接口//////////////
-(void) uploadparam:(NSDictionary *)param
filedata:(NSData *)data
filename:(NSString *)filename
mimeType:(NSString *)mimeType
url:(NSString *)url

{
    self.requestType = @"upload";
    [self didStartLoad];
    [self.utl success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.Json = responseObject;
        [self requestDidFinishLoad];
    }error:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.error = error;
        NSLog(@"%@",error);
        [self requestdidFailLoadWithError:error];
    } param:param
             filedata:data
             filename:filename
             mimeType:mimeType
                  url:url
     ];
    
    
}
@end
