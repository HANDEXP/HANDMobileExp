//
//  ViewController.h
//  Login
//
//  Created by Tracy－jun on 14-7-1.
//  Copyright (c) 2014年 王俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMModelViewController.h"
#import "EXPLoginModel.h"
#import "EXPFunctionListViewController.h"
#import "EXPHomeViewController.h"

@interface EXPLoginViewController : LMModelViewController<UITextFieldDelegate>


- (IBAction)loginAction:(id)sender;

@end
