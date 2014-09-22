//
//  EXPDetailModel.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-13.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "FMDataBaseModel.h"
#import "LMSectioneDataSource.h"
#import "EXPDetailViewController.h"

@interface EXPDetailModel : FMDataBaseModel

- (void)deleteCell:(NSArray *)dictionary;
@end

@interface EXPDetailDataSource :LMSectioneDataSource
@property (nonatomic,strong)EXPDetailViewController * DetailTvC;

@end