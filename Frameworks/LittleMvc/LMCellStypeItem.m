//
//  LMCellStypeItem.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-14.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMCellStypeItem.h"

@implementation LMCellStypeItem


#pragma mark Class public

+ (id)itemWithText:(id)delegate selector :(SEL)selector
{
    LMCellStypeItem* item = [[self alloc] init];

    item.selector =selector;
    item.delegate = delegate;
    return item;
}
@end
