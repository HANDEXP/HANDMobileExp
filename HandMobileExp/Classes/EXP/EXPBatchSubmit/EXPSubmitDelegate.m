//
//  EXPSubmitDelegate.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-22.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPSubmitDelegate.h"
#import "LMCellStypeItem.h"


@implementation EXPSubmitDelegate
-(id)init{
    self = [super init];
    if(self){
        self.selectIndex = [[NSMutableArray alloc] init];
        
    }
    return self;
}

#pragma  UItableViewdelegate
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id<LMTableViewDataSource> dataSource = (id<LMTableViewDataSource>)tableView.dataSource;
    LMCellStypeItem *  item = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    

    [self.selectIndex removeObject:item.primary_id];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id<LMTableViewDataSource> dataSource = (id<LMTableViewDataSource>)tableView.dataSource;
    LMCellStypeItem *  item = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    
    [self.selectIndex addObject:item.primary_id];
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

@end
