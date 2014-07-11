//
//  LMTableDateInputCell.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-9.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMTableDateInputCell;
@protocol DateInputTableViewCellDelegate <NSObject>
@optional
- (void)tableViewCell:(LMTableDateInputCell *)cell didEndEditingWithDate:(NSDate *)value;
@end


@interface LMTableDateInputCell : UITableViewCell{
    UIPopoverController *popoverController;
	UIToolbar *inputAccessoryView;
}

@property (nonatomic, strong) NSDate *dateValue;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic,strong)  id<DateInputTableViewCellDelegate> delegate;





- (void)setMaxDate:(NSDate *)max;
- (void)setMinDate:(NSDate *)min;
- (void)setMinuteInterval:(NSUInteger)value;
@end
