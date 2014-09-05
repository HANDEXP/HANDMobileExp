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
#import "EXPUnlockSettingViewController.h"
#import "EXPPasswordSetting.h"

@interface EXPDataSettingViewController ()

@end

@implementation EXPDataSettingViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {        // Load
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:29.0f/255.0f green:92.0f/255.0f blue:145.0f/255 alpha:1];
    }
    else {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:29.0f/255.0f green:92.0f/255.0f blue:145.0f/255 alpha:1];
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
    if(indexPath.item  == 3 ){
        self.model.tag = @"3";
        [self.model loadExpenseClass];

    }
    
    if (indexPath.item == 7) {
        

        UIStoryboard *StoryBoard = [UIStoryboard storyboardWithName:@"SettingStoryboard" bundle:nil];
     EXPPasswordSetting    * passSetting = [StoryBoard instantiateViewControllerWithIdentifier:@"EXPPasswordSetting"];
        
        [self.navigationController pushViewController:passSetting animated:YES];
        
        
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

- (void)modelDidFinishLoad:(id<TTModel>)pmodel{
       EXPDataSettingModel * _pmodel =  pmodel;
    
    if([_pmodel.tag isEqualToString:@"3"]){
        
        NSDictionary * head = [_model.Json valueForKey:@"head"];
        NSString * ressult = [head valueForKey:@"code"];
        
        if([ressult isEqualToString:@"success"]){
        
        NSArray  * arr = [[_pmodel.Json valueForKey:@"body"] valueForKey:@"list"];
        
        [[NSUserDefaults standardUserDefaults] setValue:arr forKey:@"expense_classes"];
    
        [[NSUserDefaults standardUserDefaults] synchronize];
            
            showAlterView_1(@"数据同步成功", @"提示", nil);
        
        }else{
            
            showAlterView(_pmodel.error.debugDescription, @"错误信息", nil);
        }
        
    }
    
}

@end
