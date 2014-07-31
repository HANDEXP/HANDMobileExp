//
//  EXPDataSettingViewController.m
//  HandMobileExp
///Users/hand/Documents/PROJECT/HANDMobileExp/HandMobileExp.xcodeproj
//  Created by jiangtiteng on 14-7-30.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPDataSettingViewController.h"
#import "EXPDataSettingModel.h"
#import  "LMAlertViewTool.h"

@interface EXPDataSettingViewController ()

@end

@implementation EXPDataSettingViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {        // Load
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.914 green:0.924 blue:0.821 alpha:1.000];
    }
    else {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.914 green:0.924 blue:0.821 alpha:1.000];
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    }

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(presentLeftMenuViewController:)];
    
    self.model = [[EXPDataSettingModel alloc] init];
    [self.model.delegates addObject:self];

    
    [self.exitButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [self.exitButton.layer setBorderWidth:0.7];
    
    [self.exitButton addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchDown];
    

    self.title = @"设置";
    

}
- (void) exit:(UIButton *)paramSender{
    showAlterView(@"是否退出当前软件", @"信息", self);
    
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    //数据同步
    if(indexPath.item  == 2 ){
        [self.model loadExpenseClass];

    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma alertDelegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        
        
    }else if(buttonIndex == 1){
        [UIView beginAnimations:@"exitApplication" context:nil];
        
        [UIView setAnimationDuration:0.5];
        
        [UIView setAnimationDelegate:self];
        
        
        [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.superview  cache:NO];
        
        
         [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
        
        self.view.bounds = CGRectMake(0, 0, 0, 0);
        
        [UIView commitAnimations];
        
    }
   
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}

#pragma mark - LMModelDelegate
-(void)model:(id<TTModel>)model didFailLoadWithError:(NSError *)error{
    
    
}

- (void)modelDidFinishLoad:(id<TTModel>)model{
   
}

@end
