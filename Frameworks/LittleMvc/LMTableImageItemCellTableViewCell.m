//
//  LMTableImageItemCellTableViewCell.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-5.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableImageItemCellTableViewCell.h"

@implementation LMTableImageItemCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


#pragma mark -
#pragma mark TTTableViewCell

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
    if (_item != object) {
        _item = object;
        NSLog(@"_item.text is %@",_item.text);
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.text = _item.text;
        self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.highlightedTextColor = [UIColor colorWithWhite:0.435 alpha:1.000];
        self.selectedBackgroundView = [[UIView alloc] init];
        self.imageView.image = [UIImage imageNamed:@"timeSheetFill"];
        }
    
}

@end
