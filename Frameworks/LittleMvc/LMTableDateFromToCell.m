//
//  LMTableDateFromToCell.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-8-19.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableDateFromToCell.h"
#import "NSDate+Convenience.h"
#import "EventKitDataSource.h"

@implementation LMTableDateFromToCell{
    
    EventKitDataSource *dataSource;
}


@synthesize dateFormatter;
@synthesize kal;
@synthesize dateFromValue;
@synthesize dateToValue;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"LMTableDateFromToCell" owner:self options:nil ];
        self = [nibArray objectAtIndex:0];
        
        //日期组件
        kal = [[KalViewController alloc] initWithSelectionMode:KalDoubleClickMode];
        kal.beginDate = [NSDate dateStartOfDay:[NSDate date]];
        kal.endDate = [NSDate dateStartOfDay:[NSDate date]];
        kal.title = @"选择日期";
        
        /*
         *    Kal Configuration
         *
         */
//        kal.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Today", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(showAndSelectToday)];
        
        dataSource = [[EventKitDataSource alloc] init];
        dataSource.cell = self;
        kal.dataSource = dataSource;
        
        [self initalizeInputView];
   
        
        
    }
    return self;
}



- (void)initalizeInputView {
    
    //初始化日期
    dateToValue = [NSDate date];
	dateFromValue = [NSDate date];
	

	
	self.dateFormatter = [[NSDateFormatter alloc] init];
    
	self.dateFormatter.timeStyle = NSDateFormatterNoStyle;
	self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    self.dateFrom.text = [self.dateFormatter stringFromDate:dateFromValue];
    self.dateTo.text = [self.dateFormatter stringFromDate:dateToValue];

	
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    
    
	if (selected) {
        [self.parent.navigationController pushViewController:kal animated:YES];
	}
}



@end
