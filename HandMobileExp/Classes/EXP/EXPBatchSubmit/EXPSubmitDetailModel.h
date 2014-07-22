//
//  EXPDetailModel.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-13.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "FMDataBaseModel.h"
#import "LMSectioneDataSource.h"

@interface EXPSubmitDetailModel : FMDataBaseModel

@end

@interface EXPSubmitDetailDataSource :LMSectioneDataSource
@property (nonatomic,strong)UIViewController * DetailTvC;

@end