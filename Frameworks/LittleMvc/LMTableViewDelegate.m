//
//  LMTableViewDelegate.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-5.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableViewDelegate.h"
#import "LMTableLinkedItem.h"

@implementation LMTableViewDelegate

#pragma mark -
#pragma mark NSObject

-(id)initWithController:(LMTableViewController *)controller{
    self = [super init];
    if(self){
        _controller = controller;
        
    }
    return self;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
      id<LMTableViewDataSource> dataSource = (id<LMTableViewDataSource>)tableView.dataSource;
     id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    
    if([object isKindOfClass:[LMTableLinkedItem class]]){
        LMTableLinkedItem *item = object;
        if(item.delegate && item.selector){
            
            [item.delegate performSelector:item.selector withObject:object];
        }
        
        
        
}
    
    
}

@end