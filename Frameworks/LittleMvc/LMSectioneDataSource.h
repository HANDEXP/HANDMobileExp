//
//  LMSectionedSource.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-5.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMTableViewDataSource.h"

@interface LMSectioneDataSource : LMTableViewDataSource{
    NSMutableArray * _sections;
    NSMutableArray * _items;
}

@property (nonatomic, retain) NSMutableArray* items;
@property (nonatomic, retain) NSMutableArray* sections;

@end
