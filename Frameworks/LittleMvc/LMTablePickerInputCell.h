//
//  LMTablePickerInputCell.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-10.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMTablePickerInputCell : UITableViewCell<UIKeyInput, UIPopoverControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
	// For iPad
	UIPopoverController *popoverController;
	UIToolbar *inputAccessoryView;
}

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic,strong)NSArray *item1;
@property (nonatomic,strong)NSArray *item2;
@property (nonatomic,strong) NSString * place_desc;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;


@end
