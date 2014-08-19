//
//  LMTableDateFromToCell.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-8-19.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import   "Kal.h"



@interface LMTableDateFromToCell : UITableViewCell{
    UIPopoverController *popoverController;
	UIToolbar *inputAccessoryView;
}


@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;


@property (nonatomic,strong)    KalViewController *kal;
@property (nonatomic,strong) UIViewController * parent;//调用这个cell的viewcontroller



@property (strong, nonatomic) IBOutlet UILabel *dateFrom;

@property (strong, nonatomic) IBOutlet UILabel *dateTo;

@property (nonatomic, strong) NSDate * dateFromValue;
@property (nonatomic, strong) NSDate * dateToValue;


@end
