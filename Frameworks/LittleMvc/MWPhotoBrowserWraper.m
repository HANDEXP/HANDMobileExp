//
//  MWPhotoBrowserWraper.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-10-31.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "MWPhotoBrowserWraper.h"

@implementation MWPhotoBrowserWraper

@synthesize viewcontroller = _viewcontroller;
@synthesize delegate  = _delegate;
@synthesize browser = _browser;

-(id)initWithViewController:(UIViewController *)viewcontroller
                     delegate:(id<MWPhotoBrowserDelegate>)delegate
{
    self = [self init];
    if(self){
        _viewcontroller = viewcontroller;
        _delegate = delegate;
        
        [self initialisation ];
        
        
        
        
    }
    
    return self;
    
}

-(void)initialisation
{
    
    _browser = [[MWPhotoBrowser alloc] initWithDelegate:_delegate];
    
    _browser.displayActionButton = YES;
    _browser.displayNavArrows = YES;
    _browser.displaySelectionButtons = NO;
    _browser.alwaysShowControls = YES;
    _browser.zoomPhotosToFill = YES;
    _browser.displaySelectionButtons = NO;
    _browser.startOnGrid = YES;
}

-(void)showWithPush
{
    
    [self.viewcontroller.navigationController pushViewController:_browser animated:YES];
    
}


@end
