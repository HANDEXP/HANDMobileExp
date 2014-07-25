//
//  LMBasicFunctionItemCell.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-24.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMBasicFunctionItemCell.h"
#import "LMBasicFunctionItem.h"


@implementation LMBasicFunctionItemCell{
    
    LMBasicFunctionItem * _item;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"LMBasicFunctionItemCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];    }
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


- (void)setObject:(id)object {
    if (_item != object) {
        _item = object;

        self.backgroundColor = [UIColor clearColor];
        
        self.image.image = [UIImage imageNamed:_item.imageUrl];
        self.title.text = _item.title;
        self.title.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        self.title.textColor = [UIColor blackColor];
        self.title.highlightedTextColor = [UIColor colorWithWhite:0.435 alpha:1.000];
        self.selectedBackgroundView = [[UIView alloc] init];

    }
    
}

@end
