//
//  LMTextFieldCell.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-9-21.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTextFieldCell.h"

@implementation LMTextFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"LMTextFieldCell" owner:self options:nil ];
        self = [nibArray objectAtIndex:0];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
