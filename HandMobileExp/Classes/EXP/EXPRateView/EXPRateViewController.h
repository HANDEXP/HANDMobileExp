//
//  EXPRateViewController.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-11-17.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMModelViewController.h"
#import "EXPLineModelDetailViewController.h"

@interface EXPRateViewController : LMModelViewController<UITableViewDelegate,UITableViewDataSource>


///上一层view
@property (nonatomic,strong) EXPLineModelDetailViewController * parent;


@end
