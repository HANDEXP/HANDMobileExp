//
//  EXPLocationPicker.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-21.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMTablePickerInputCell.h"

@interface EXPLocationPicker : NSObject <UIPickerViewDataSource,UIPickerViewDelegate>


@property (nonatomic,strong)NSArray *provinces;
@property (nonatomic,strong)NSArray *citys;

@property (nonatomic,strong)LMTablePickerInputCell * cell;

@property (nonatomic,strong) NSString * city_desc;
@property (nonatomic,strong) NSString * province_desc;
@end
