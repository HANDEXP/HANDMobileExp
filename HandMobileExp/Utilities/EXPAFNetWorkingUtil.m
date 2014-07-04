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
        NSLog(@"%@",basePath);
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
    
    NSLog(@"in request");
    return [self.AFAppDotNetAPIClient GET:url parameters:param success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSDictionary * test = [JSON  valueForKey:@"head"];
        NSLog(@"%@",[test valueForKey:@"code"]);

            if (successBlock) {
                successBlock(JSON);
                
            }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
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
        NSDictionary * test = [JSON  valueForKey:@"head"];
        NSLog(@"%@",[test valueForKey:@"code"]);
        
        if (successBlock) {
            successBlock(JSON);
            
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        if (errorBlock) {
            errorBlock( error);
        }
    }];
}
@end