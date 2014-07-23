//
//  EXPLineCell.h
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-9.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMCellStype : UITableViewCell

@property BOOL  m_checked;
@property (nonatomic,strong)UIImageView*	m_checkImageView;

- (void)setObject:(id)object;
- (void) setChecked:(BOOL)checked;
@end
