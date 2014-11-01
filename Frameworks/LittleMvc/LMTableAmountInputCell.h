//
//  LMTableAmountInput.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-9.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPickerActionSheetDelegate.h"
#import "ImagePickerActionSheet.h"
#import "MWPhotoBrowserWraper.h"

@class LMTableAmountInputCell;

@protocol IntegerInputTableViewCellDelegate <NSObject>
@optional
- (void)tableViewCell:(LMTableAmountInputCell *)cell didEndEditingWithInteger:(NSUInteger)value;
@end

@interface LMTableAmountInputCell : UITableViewCell<UIKeyInput, UITextInputTraits,IPickerActionSheetDelegate,MWPhotoBrowserDelegate> {
	
	BOOL valueChanged;

	UIEdgeInsets originalContentInsets;
	UIEdgeInsets originalScrollInsets;
	UIToolbar *inputAccessoryView;
    
    //标记开始输入小数
    BOOL dotBeginFlag;
    BOOL firstInput;
    BOOL endFlag;
    NSInteger  dotnumber;
    
    
    
    ImagePickerActionSheet * imagesheet;
    MWPhotoBrowserWraper * _photowrapper;
    
}

@property (nonatomic, assign) float numberValue;
@property (nonatomic, assign) float lowerLimit;
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


@property (strong,nonatomic) NSMutableArray * imageArray;


@end
