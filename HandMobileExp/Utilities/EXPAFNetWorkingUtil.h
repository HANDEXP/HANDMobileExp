//
//  EXPAFNetWorkingUtil.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-2.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDSingletonObject.h"
#import "AFHTTPSessionManager.h"

@interface EXPAFNetWorkingUtil : HDSingletonObject
@property (strong) AFHTTPSessionManager * AFAppDotNetAPIClient;
@property (strong)NSString *baseUrl;


//设置http头
-(void)setValue:(NSString *)Value
forHTTPHeaderField :(NSString *)field;

-(void)setacceptContentTypes:(NSSet *)objects;

-(NSURLSessionDataTask *)getsuccess :(void (^)(id JSON))successBlock
                           geterror :(void (^)(NSError *error))errorBlock
                               param:(NSMutableDictionary * )param
                                url :(NSString *)url;

-(NSURLSessionDataTask *)postsuccess :(void (^)(id JSON))successBlock
                           posterror :(void (^)(NSError *error))errorBlock
                                param:(NSMutableDictionary * )param
                                 url :(NSString *)url;


@end