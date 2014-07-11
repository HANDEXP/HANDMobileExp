//
//  LMSectionedSource.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-5.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMSectioneDataSource.h"

@implementation LMSectioneDataSource

@synthesize items     = _items;
@synthesize sections  = _sections;

- (id)initWithItems:(NSArray*)items sections:(NSArray*)sections {
	self = [self init];
    if (self) {
        _items    = [items mutableCopy];
        _sections = [sections mutableCopy];
    }
    
    return self;
}


#pragma mark -
#pragma mark UITableViewDataSource
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections ? _sections.count : 1;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_sections) {
        NSArray* items = [_items objectAtIndex:section];
        NSLog(@" line is %d",items.count);
        return items.count;
            
    } else {
        return _items.count;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_sections.count) {
        
    }
    return nil;

}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark LMTableViewDataSource

- (id)tableView:(UITableView*)tableView objectForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (_sections) {
        NSArray* section = [_items objectAtIndex:indexPath.section];
        return [section objectAtIndex:indexPath.row];
        
    } else {
        return [_items objectAtIndex:indexPath.row];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSIndexPath*)tableView:(UITableView*)tableView indexPathForObject:(id)object {
    if (_sections) {
        for (int i = 0; i < _items.count; ++i) {
            NSMutableArray* section = [_items objectAtIndex:i];
            NSUInteger objectIndex = [section indexOfObject:object];
            if (objectIndex != NSNotFound) {
                return [NSIndexPath indexPathForRow:objectIndex inSection:i];
            }
        }
        
    } else {
        NSUInteger objectIndex = [_items indexOfObject:object];
        if (objectIndex != NSNotFound) {
            return [NSIndexPath indexPathForRow:objectIndex inSection:0];
        }
    }
    
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public




@end