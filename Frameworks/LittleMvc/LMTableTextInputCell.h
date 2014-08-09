//
//  LMTableTextInputCell.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-8-8.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMTableTextInputCell : UITableViewCell<UIKeyInput, UITextInputTraits>


@property(nonatomic) UIKeyboardType keyboardType;

@property(nonatomic,assign) NSUInteger numberValue;
@property (nonatomic, assign) NSUInteger lowerLimit;
@property (nonatomic, assign) NSUInteger upperLimit;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;


@end
