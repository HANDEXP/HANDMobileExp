//
//  ViewController.m
//  Login
//
//  Created by Tracy－jun on 14-7-1.
//  Copyright (c) 2014年 王俊. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    EXPLoginModel * loginmodel = [[EXPLoginModel alloc] init];
    [[loginmodel delegates] addObject:self];
    [loginmodel load];
    
    
}




#pragma -mark TTModel Functions
-(void)modelDidFinishLoad:(id<TTModel>)model
{

    NSLog(@"didfinishload");
}

// tap dismiss keyboard
-(void)dismissKeyboard {
    [self.view endEditing:YES];
    [self.passwordTF resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
