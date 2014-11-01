//
//  EXPDetailModel.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-13.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "FMDataBaseModel.h"
#import "LMSectioneDataSource.h"
#import  "AFNetRequestModel.h"

@interface EXPSubmitDetailModel : FMDataBaseModel
-(void)update:(NSArray *)param;
@end

@interface EXPSubmitHttpModel :AFNetRequestModel

-(void)postLine:(NSDictionary *)parm;

- (void)upload:(NSDictionary *)param
      fileName:(NSString *)fileName
          data:(NSData *)data;

/////多张照片上传

- (void)upload:(NSDictionary *)param
         files:(NSMutableArray *)files;


-(void)upload:(NSDictionary *)param;
@end

@interface EXPSubmitDetailDataSource :LMSectioneDataSource
@property (nonatomic,strong)UIViewController * DetailTvC;

@end