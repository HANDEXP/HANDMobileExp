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
@property (nonatomic) NSInteger  amount;
@property (nonatomic) NSString * expense_type_desc;
@property (nonatomic) NSString * line_desc;

+ (id)itemWithText:(id)delegate selector :(SEL)selector;
@end
