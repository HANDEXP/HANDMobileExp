//
//  EXPdateSwitchView.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-30.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPdateSwitchView.h"

@interface EXPdateSwitchView ()

@property (nonatomic, strong)UIButton *preDateButton;
@property (nonatomic, strong)UIButton *nextDateButton;
@property (nonatomic, strong)UILabel *dateLabel;

@end

@implementation EXPdateSwitchView

@synthesize preDateButton,nextDateButton,dateLabel;

- (id)initWithFrame:(CGRect)frame Date:(NSString *)date Color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = color;
        
        
        preDateButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width/4, self.frame.size.height)];
        [preDateButton setImage:[UIImage imageNamed:@"leftDate"] forState:UIControlStateNormal];
        preDateButton.backgroundColor = [UIColor clearColor];
        [preDateButton addTarget:self action:@selector(preButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:preDateButton];
        
        nextDateButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width*3/4, 0.0, self.frame.size.width/4, self.frame.size.height)];
        nextDateButton.backgroundColor = [UIColor clearColor];
        [nextDateButton setImage:[UIImage imageNamed:@"rightDate"] forState:UIControlStateNormal];
        [nextDateButton addTarget:self action:@selector(nextButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:nextDateButton];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/4, 0.0, self.frame.size.width/2, self.frame.size.height)];
        [dateLabel setTextAlignment:NSTextAlignmentCenter];
        dateLabel.text = date;
        [self addSubview:self.dateLabel];
        
    }
    return self;
}

- (void)nextButtonClicked:(id) sender
{
    if ([self.delegate respondsToSelector:@selector(preDateButtonClicked:)]) {
        [self.delegate nextDateButtonClicked:self];
    }
}

- (void)preButtonClicked:(id) sender
{
    if ([self.delegate respondsToSelector:@selector(preDateButtonClicked:)]) {
        [self.delegate preDateButtonClicked:self];
    }
}

- (void)setDateLabelText:(NSString *)text
{
    self.dateLabel.text = text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
