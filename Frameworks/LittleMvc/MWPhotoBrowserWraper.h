//
//  MWPhotoBrowserWraper.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-10-31.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPhotoBrowser.H"

@interface MWPhotoBrowserWraper : NSObject

@property (nonatomic, weak) IBOutlet id<MWPhotoBrowserDelegate> delegate;

@property (nonatomic) NSUInteger delayToHideElements;
@property (nonatomic, readonly) NSUInteger currentIndex;

@property (nonatomic,strong)UIViewController * viewcontroller;

@property (nonatomic,strong)MWPhotoBrowser * browser;

-(id)initWithViewController:(UIViewController *)viewcontroller
                   delegate:(id<MWPhotoBrowserDelegate>)delegate;


-(void)showWithPush;
@end
