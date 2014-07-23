//
//  EXPLineCell.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-9.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMCellStype.h"
#import "LMCellStypeItem.h"

@implementation LMCellStype{
    
    LMCellStypeItem * _item;
    
    UIImageView*	m_checkImageView;
}

@synthesize m_checkImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"LMCellStype" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
        self.clipsToBounds =YES;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
    if (_item != object) {
        _item = object;
        NSString *text;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.detailTextLabel.text = [NSString stringWithFormat:@"¥%@",_item.amount];
        self.textLabel.text = _item.expense_type_desc;
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
