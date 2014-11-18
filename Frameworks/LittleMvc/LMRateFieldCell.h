//
//  LMRateFieldCell.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-11-17.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPLineModelDetailViewController.h"

@interface LMRateFieldCell : UITableViewCell<UIKeyInput, UITextInputTraits>{
    
    	BOOL valueChanged;
    
    	UIToolbar *inputAccessoryView;
}

@property (strong, nonatomic) IBOutlet UILabel *currencyLabel;

@property (strong, nonatomic) IBOutlet UILabel *exchangRateLabel;



@property (nonatomic, assign) float numberValue;


@property (nonatomic, assign) float lowerLimit;
@property (nonatomic, assign) NSUInteger upperLimit;
@property(nonatomic) UIKeyboardType keyboardType;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@property (nonatomic,strong)EXPLineModelDetailViewController * parent;

@end
