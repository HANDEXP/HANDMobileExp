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

@end

@interface EXPSubmitHttpModel :AFNetRequestModel

-(void)postLine:(NSDictionary *)parm;

- (void)upload:(NSDictionary *)param
      fileName:(NSString *)fileName
          data:(NSData *)data;
@end

@interface EXPSubmitDetailDataSource :LMSectioneDataSource
@property (nonatomic,strong)UIViewController * DetailTvC;

@end