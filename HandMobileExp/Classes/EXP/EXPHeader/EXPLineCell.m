//
//  EXPLineCell.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-9.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPLineCell.h"


@implementation EXPLineCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"EXPCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
