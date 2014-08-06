//
//  EXPAFNetWorkingUtil.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-2.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPAFNetWorkingUtil.h"

@implementation EXPAFNetWorkingUtil

+(id)shareHTTPRequestCenter
{
    return [self shareObject];
}
-(id) init{
    self = [super init];
    if (self){
        self.baseUrl = [self getBaseUrl];
        self.AFAppDotNetAPIClient =[[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseUrl]];
        self.AFAppDotNetAPIClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    }
    return self;
}
-(NSString *)getBaseUrl{
    NSString * basePath = [[NSUserDefaults standardUserDefaults]stringForKey:@"base_url_preference"];
    return basePath;
}

//设置http头
-(void)setValue:(NSString *)Value
forHTTPHeaderField :(NSString *)field
{
    [self.AFAppDotNetAPIClient.requestSerializer  setValue:Value forHTTPHeaderField:field];
}
-(void)setacceptContentTypes:(NSSet *)objects{
    self.AFAppDotNetAPIClient.responseSerializer.acceptableContentTypes = objects;
}

-(NSURLSessionDataTask *)getsuccess :(void (^)(id JSON))successBlock
                           geterror :(void (^)(NSError *error))errorBlock
                               param:(NSMutableDictionary * )param
                                url :(NSString *)url
{
    
    return [self.AFAppDotNetAPIClient GET:url parameters:param success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        if (successBlock) {
            successBlock(JSON);
            
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (errorBlock) {
            errorBlock( error);
        }
    }];
}


-(NSURLSessionDataTask *)postsuccess :(void (^)(id JSON))successBlock
                           posterror :(void (^)(NSError *error))errorBlock
                                param:(NSMutableDictionary * )param
                                 url :(NSString *)url
{
    
    
    return [self.AFAppDotNetAPIClient POST:url parameters:param success:^(NSURLSessionDataTask * __unused task, id JSON) {

        
        if (successBlock) {
            successBlock(JSON);
            
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (errorBlock) {
            errorBlock( error);
        }
    }];
}

-(void) success:(void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
         error :(void (^)(AFHTTPRequestOperation *operation, NSError *error))error
          param:(NSMutableDictionary *)param
       filedata:(NSData *)data
       filename:(NSString *)filename
       mimeType:(NSString *)mimeType
            url:(NSString *)url{
    NSString * fullPath = [self.baseUrl  stringByAppendingString:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager POST:fullPath parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:filename  fileName:filename mimeType:mimeType];
        
    } success:success
          failure:error];
    
    
    
}

//formdata中不包含数据流
-(void) success:(void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
         error :(void (^)(AFHTTPRequestOperation *operation, NSError *error))error
          param:(NSMutableDictionary *)param
            url:(NSString *)url{
    NSString * fullPath = [self.baseUrl  stringByAppendingString:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager POST:fullPath parameters:param constructingBodyWithBlock:nil success:success
          failure:error];
    
    
    
}

@end
