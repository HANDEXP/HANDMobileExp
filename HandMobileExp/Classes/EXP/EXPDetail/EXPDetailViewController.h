//
//  EXPDetailViewController.h
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-10.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMTableViewController.h"

@interface EXPDetailViewController : LMTableViewController<UITableViewDataSource,UITableViewDelegate>

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumMoneyLabel;

@end
