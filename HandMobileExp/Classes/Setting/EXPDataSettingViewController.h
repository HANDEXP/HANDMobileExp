//
//  EXPDataSettingViewController.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-30.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPDataSettingModel.h"
#import "LMModelDelegate.h"

@interface EXPDataSettingViewController : UITableViewController  <UITableViewDelegate,LMModelDelegate>


@property (strong, nonatomic) IBOutlet UIButton *exitButton;
@property (strong,nonatomic)  EXPDataSettingModel * model;

@end
