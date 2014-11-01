//
//  AFNetRequestModel.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-3.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMRequestModel.h"
#import "EXPAFNetWorkingUtil.h"

@interface AFNetRequestModel : LMRequestModel
@property(strong) NSMutableArray * Json;
@property(strong) NSError   *error;
@property(nonatomic,retain) EXPAFNetWorkingUtil * utl;
@property(nonatomic,retain)  NSString * requestType;



-(void)request:(NSString *)method
         param:(NSDictionary *)param
           url:(NSString *)url;
-(void)setValue:(NSString *)value
forHTTPHeaderField:(NSString *)field;

-(void) uploadparam:(NSDictionary *)param
           filedata:(NSData *)data
           filename:(NSString *)filename
           mimeType:(NSString *)mimeType
                url:(NSString *)url;

-(void) param:(NSDictionary *)param
          url:(NSString *)url;

////////////批量上传图片接口//////////////
-(void) uploadparam:(NSDictionary *)param
              files:(NSMutableArray *)files
                url:(NSString *)url;
@end
