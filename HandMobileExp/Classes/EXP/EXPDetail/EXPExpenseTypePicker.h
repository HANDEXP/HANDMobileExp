//
//  EXPExpenseTypePicker.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-21.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMTablePickerInputCell.h"

@interface EXPExpenseTypePicker : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)NSArray * expense_classes;

@property (nonatomic,strong)NSNumber * expense_class_id;
@property (nonatomic,strong)NSNumber * expense_type_id;
@property (nonatomic,strong)NSString  *expense_class_desc;
@property (nonatomic,strong)NSString  * expense_type_desc;

@property (nonatomic,strong)LMTablePickerInputCell * cell;


@end
