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
#import "EXPExpenseTypePicker.h"
#import "EXPLocationPicker.h"
#import "LMAlertViewTool.h"



@interface EXPLineModelDetailViewController : LMModelViewController
<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
  UIToolbar *   inputAccessoryView;
}

@property(nonatomic,strong) UITableView * tv;
@property(nonatomic,strong)  UITextView * descTx ;


@property(nonatomic,strong) UIButton *save;
@property(nonatomic,strong) UIButton * saveAdd;
@property(nonatomic,strong) UIButton * upload;

@property BOOL insertFlag;
@property BOOL updateFlag;

@property BOOL readOnlyFlag;

@property (strong) NSNumber * keyId;

//列表
@property (nonatomic,strong) LMModelViewController  * detailList;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *coverView;


/**  汇率返回时候修改汇率 */
-(void) reloadRateCell:(NSString *)currency
          exchangeRate:(NSNumber *  )exchangRate;

@end
