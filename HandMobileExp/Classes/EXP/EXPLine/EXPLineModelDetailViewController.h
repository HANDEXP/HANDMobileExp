//
//  EXPLineModelViewController.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-8.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMModelViewController.h"
#import "LMTableDateInputCell.h"
#import "LMTableAmountInputCell.h"
#import "LMTablePickerInputCell.h"


@interface EXPLineModelDetailViewController : UIViewController
<UITableViewDataSource,DateInputTableViewCellDelegate,UITableViewDelegate,UIPickerViewDelegate,
UIPickerViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong) UITableView * tv;
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong)  UITextView * tx ;
@property(nonatomic,strong) UIButton * upload;



@end
