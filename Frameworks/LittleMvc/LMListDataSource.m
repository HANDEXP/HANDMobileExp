//
//  LMListDataSource.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-6.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMListDataSource.h"

@implementation LMListDataSource{
    
}
@synthesize items = _items;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark LMTableViewDataSource

- (id)tableView:(UITableView*)tableView objectForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.row < _items.count) {
        return [_items objectAtIndex:indexPath.row];
        
    } else {
        return nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSIndexPath*)tableView:(UITableView*)tableView indexPathForObject:(id)object {
    NSUInteger objectIndex = [_items indexOfObject:object];
    if (objectIndex != NSNotFound) {
        return [NSIndexPath indexPathForRow:objectIndex inSection:0];
    }
    return nil;
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITableViewDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}




@end
