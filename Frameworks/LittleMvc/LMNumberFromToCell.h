//
//  LMNumberFromToCell.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-9-20.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMNumberFromToCell : UITableViewCell<UIKeyInput, UITextInputTraits>

@property (strong, nonatomic) IBOutlet UIView *leftNumberView;

@property (strong, nonatomic) IBOutlet UIView *rightNumberView;

@property(nonatomic) UIKeyboardType keyboardType;
@end
