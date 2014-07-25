//
//  LMTableViewController.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-4.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMModelViewController.h"
#import "LMTableViewDataSource.h"

@interface LMTableViewController : LMModelViewController<UIGestureRecognizerDelegate>{
    
       UITableView*  _tableView;
      id<LMTableViewDataSource> _dataSource;
      id<UITableViewDelegate>   _tableDelegate;
}
@property (nonatomic, strong) id<LMTableViewDataSource> dataSource;
@property (nonatomic, strong)  UITableView* tableView;

- (id<UITableViewDelegate>)createDelegate;

@end
