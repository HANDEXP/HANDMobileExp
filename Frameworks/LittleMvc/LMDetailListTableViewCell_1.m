//
//  LMDetailListTableViewCell.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-28.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMDetailListTableViewCell_1.h"
#import "LMCellStypeItem.h"

@implementation LMDetailListTableViewCell_1
{
    
    LMCellStypeItem * _item;
    
    UIImageView*	m_checkImageView;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"LMDetailListTableViewCell_1" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
        self.clipsToBounds =YES;
    }
    return self;
}


- (void)setObject:(id)object {
    if (_item != object) {
        _item = object;
        NSString *text;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.amountLabel.text = [NSString stringWithFormat:@"¥%.2f",_item.amount];
        self.typeLabel.text = _item.expense_type_desc;
        if (_item.line_desc.length != 0) {
            self.dateLabel.text = _item.line_desc;
        }
        
        if ([_item.status compare:@"new"] != 0) {
            [self.statusImageView setImage:[UIImage imageNamed:@"stamp"]];
        }else{
            [self.statusImageView setImage:[UIImage imageNamed:@""]];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
