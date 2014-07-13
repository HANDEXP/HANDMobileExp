//
//  EXPHomeViewController.h
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-7.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableViewController.h"
#import "EXPHeaderViewController.h"

@interface EXPHomeViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)EXPHeaderViewController *headerVIewController;
@end
