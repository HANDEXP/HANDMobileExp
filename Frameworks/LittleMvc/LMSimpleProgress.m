//
//  LMSimpleProgress.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-23.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMSimpleProgress.h"

@implementation LMSimpleProgress
{
    UIView * coverView;
    UIActivityIndicatorView * indicator;
    
    
}

#pragma mark - Class Methods
+ (LMSimpleProgress *)sharedHUD{
    static LMSimpleProgress *_LMSimpleProgress = nil;
    
    static dispatch_once_t _LMSimpleProgressToken;
    dispatch_once(&_LMSimpleProgressToken, ^{
        _LMSimpleProgress = [[LMSimpleProgress alloc] init];
         NSLog(@"hello");
    });
   
    
    return _LMSimpleProgress;
}


+(void)showprogress:(UIView *)owner
{
    LMSimpleProgress * _LMSimpleProgress = [LMSimpleProgress sharedHUD];
    [_LMSimpleProgress coverOwner:owner];
    
    
}

+(void)hideprogress
{
    
    
}

#pragma private
-(void)hideOwner:(UIView *)Owner
{
    if(coverView !=nil){
        [coverView removeFromSuperview];
    }
}

-(void)coverOwner:(UIView *)Owner
{
    if(coverView == nil){
        
        coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Owner.bounds.size.width, Owner.bounds.size.height)];
        NSLog(@"fefef");
    }
    
    if(indicator ==nil){
        
        indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(Owner.bounds.size.width/2, Owner.bounds.size.height/2, 10, 10)];
//        [coverView addSubview:indicator];
        NSLog(@"fefefe");
        
    }
    
    [Owner addSubview:coverView];
    [Owner addSubview:indicator];
    [indicator startAnimating];
    
}
@end
