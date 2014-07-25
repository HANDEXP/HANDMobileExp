//
//  LMBasicFunctionItem.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-24.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableLinkedItem.h"

@interface LMBasicFunctionItem :LMTableLinkedItem

@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)NSString *imageUrl;



+(id)initWithTitle:(NSString *)title
        imageUrl  :(NSString *)imageUrl
          delegate:(id)delegate
         selector :(SEL)selector;
@end
