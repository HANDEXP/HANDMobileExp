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


@interface EXPLineModelDetailViewController : LMModelViewController
<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

@property(nonatomic,strong) UITableView * tv;
@property(nonatomic,strong)  UITextView * descTx ;
@property(nonatomic,strong) UIButton *save;
@property(nonatomic,strong) UIButton * saveAdd;
@property(nonatomic,strong) UIButton * upload;

@property BOOL insertFlag;
@property BOOL updateFlag;
@property (strong) NSNumber * keyId;
@end
