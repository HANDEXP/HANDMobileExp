//
//  LMTablePickerInputCell.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-10.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMTablePickerInputCell : UITableViewCell<UIKeyInput, UIPopoverControllerDelegate> {
	// For iPad
	UIPopoverController *popoverController;
	UIToolbar *inputAccessoryView;
}

@property (nonatomic, strong) UIPickerView *picker;





@end
