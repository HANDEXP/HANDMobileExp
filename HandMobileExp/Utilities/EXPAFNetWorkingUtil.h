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
#import "AFHTTPRequestOperationManager.h"

@interface EXPAFNetWorkingUtil : HDSingletonObject
@property (strong) AFHTTPSessionManager * AFAppDotNetAPIClient;
@property (strong)NSString *baseUrl;
@property (strong) AFHTTPRequestOperationManager *manager;



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


//一张照片的支持
-(void) success:(void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
         error :(void (^)(AFHTTPRequestOperation *operation, NSError *error))error
          param:(NSMutableDictionary *)param
       filedata:(NSData *)data
       filename:(NSString *)filename
       mimeType:(NSString *)mimeType
            url:(NSString *)url;

///////////上传多张照片接口
-(void)success:(void (^)(AFHTTPRequestOperation *, id))success
         error:(void (^)(AFHTTPRequestOperation *, NSError *))error
         param:(NSMutableDictionary *)param
         files:(NSMutableArray *)files
           url:(NSString *)url;

-(void) success:(void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
         error :(void (^)(AFHTTPRequestOperation *operation, NSError *error))error
          param:(NSMutableDictionary *)param
            url:(NSString *)url;
@end
