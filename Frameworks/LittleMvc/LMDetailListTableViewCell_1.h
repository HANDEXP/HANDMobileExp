//
//  LMDetailListTableViewCell.h
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-28.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMDetailListTableViewCell_1 : UITableViewCell

@property BOOL  m_checked;
@property (nonatomic,strong)UIImageView*	m_checkImageView;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;


- (void)setObject:(id)object;
- (void) setChecked:(BOOL)checked;

@end
