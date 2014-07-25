//
//  LMBasicFunctionItemCell.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-24.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMBasicFunctionItemCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *title;

- (void)setObject:(id)object;

@end
