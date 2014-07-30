//
//  EXPdateSwitchView.h
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-30.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EXPdateSwitchView;

@protocol EXPdateSwitchViewDelegate <NSObject>

@optional
- (void)preDateButtonClicked:(EXPdateSwitchView *)dateSwitchView;
- (void)nextDateButtonClicked:(EXPdateSwitchView *)dateSwitchView;

@end

@interface EXPdateSwitchView : UIView

@property (nonatomic, weak) id<EXPdateSwitchViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame Date:(NSString *)date Color:(UIColor *)color;
- (void)setDateLabelText:(NSString *)text;

@end
