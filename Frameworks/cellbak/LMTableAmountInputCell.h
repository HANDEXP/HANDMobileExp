//
//  LMTableAmountInput.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-9.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LMTableAmountInputCell;

@protocol IntegerInputTableViewCellDelegate <NSObject>
@optional
- (void)tableViewCell:(LMTableAmountInputCell *)cell didEndEditingWithInteger:(NSUInteger)value;
@end

@interface LMTableAmountInputCell : UITableViewCell<UIKeyInput, UITextInputTraits> {
	BOOL valueChanged;
	NSUInteger lowerLimit;
	NSUInteger upperLimit;
	
	UIToolbar *inputAccessoryView;
	UIEdgeInsets originalContentInsets;
	UIEdgeInsets originalScrollInsets;
    
    
}


@property (nonatomic, assign) NSUInteger lowerLimit;
@property (nonatomic, assign) NSUInteger upperLimit;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (nonatomic,strong)  id<IntegerInputTableViewCellDelegate> delegate;

@property(nonatomic) UITextAutocapitalizationType autocapitalizationType;
@property(nonatomic) UITextAutocorrectionType autocorrectionType;
@property(nonatomic) BOOL enablesReturnKeyAutomatically;
@property(nonatomic) UIKeyboardAppearance keyboardAppearance;
@property(nonatomic) UIKeyboardType keyboardType;
@property(nonatomic) UIReturnKeyType returnKeyType;
@property(nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;
@property(nonatomic) UITextSpellCheckingType spellCheckingType;

@property (strong, nonatomic) IBOutlet UILabel *amount;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) UIViewController *tv;


@end
