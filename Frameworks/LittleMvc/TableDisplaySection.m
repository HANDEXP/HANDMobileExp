//
//  TableDisplaySection.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-14.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "TableDisplaySection.h"

@implementation TableDisplaySection
+(id)initwith:(NSString *)item1
        item2:(NSString *)item2
{
    
    TableDisplaySection * section = [[TableDisplaySection alloc] init];

    section.item1 = item1;
    section.item2 = item2;
    return  section;
}


-(UIView *) getView{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    NSString *blankString = @"  ";
    NSString *string =[blankString stringByAppendingString:self.item1];
    label.text = string;
    label.textColor = [UIColor colorWithWhite:0.000 alpha:0.410];
    label.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
    label.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.140];
    [label sizeToFit];
    return label;
}
@end
