//
//  LMListDataSource.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-6.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableViewDataSource.h"

@interface LMListDataSource : LMTableViewDataSource{
    NSMutableArray* _items;
}
@property (nonatomic, retain) NSMutableArray* items;
@end
