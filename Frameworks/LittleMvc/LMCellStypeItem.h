//
//  LMCellStypeItem.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-14.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableLinkedItem.h"

@interface LMCellStypeItem : LMTableLinkedItem


@property (nonatomic, assign) id        delegate;
@property (nonatomic, assign) SEL       selector;
@property (nonatomic) float  amount;
@property (nonatomic,strong) NSString * expense_type_desc;
@property (nonatomic,strong) NSString * line_desc;
@property (nonatomic,strong) NSNumber *  primary_id;
@property (nonatomic, strong) NSString *status;
@property (nonatomic,strong)NSNumber * expense_class_id;
@property (nonatomic,strong)NSString * imageDisplay;


+ (id)itemWithText:(id)delegate selector :(SEL)selector;
@end
