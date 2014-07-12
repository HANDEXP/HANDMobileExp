//
//  EXPScrollView.h
//  ScrollView
//
//  Created by Hu Di on 13-10-11.
//  Copyright (c) 2013年 Sanji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPPageControl.h"
@protocol EXPScrollviewDelegate <NSObject>
-(void)TapView:(int)index;
@end

@interface EXPScrollview : UIScrollView<UIScrollViewDelegate>

@property (nonatomic,strong) EXPPageControl *pagecontrol;
@property (nonatomic,assign) NSInteger currentPageIndex;
@property (assign,nonatomic) id<EXPScrollviewDelegate> EXPdelegate;
/**
 *	@brief	不循环
 */
-(id)initWithFrame:(CGRect)frame withImageView:(NSMutableArray *)imageview;

/**
 *	@brief	循环滚动
 */
-(id)initLoopScrollWithFrame:(CGRect)frame withImageView:(NSMutableArray *)imageview;
-(void)EXPscrollViewDidScroll;
-(void)EXPscrollViewDidEndDecelerating;
@end



