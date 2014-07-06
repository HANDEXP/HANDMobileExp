//
//  LMTableLinkedItem.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-6.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableItem.h"

@interface LMTableLinkedItem : LMTableItem{
    NSString* _URL;
    NSString* _accessoryURL;
    
    __unsafe_unretained id        _delegate;
    SEL       _selector;
}

@property (nonatomic, strong) 	NSString* URL;
@property (nonatomic, strong)   NSString* accessoryURL;
@property (nonatomic, assign) id        delegate;
@property (nonatomic, assign) SEL       selector;

@end
