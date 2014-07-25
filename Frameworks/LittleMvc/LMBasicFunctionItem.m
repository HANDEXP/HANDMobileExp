//
//  LMBasicFunctionItem.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-24.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMBasicFunctionItem.h"

@implementation LMBasicFunctionItem


+(id)initWithTitle:(NSString *)title
        imageUrl  :(NSString *)imageUrl
        delegate:(id)delegate
        selector :(SEL)selector
{
    LMBasicFunctionItem * item = [[LMBasicFunctionItem alloc] init];
    item.imageUrl = imageUrl;
    item.title =title;
    item.delegate = delegate;
    item.selector = selector;
    return  item;
    
}

@end
