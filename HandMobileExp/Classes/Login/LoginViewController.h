//
//  ViewController.h
//  Login
//
//  Created by Tracy－jun on 14-7-1.
//  Copyright (c) 2014年 王俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMModel.h"
#import "EXPLoginModel.h"

@interface LoginViewController : UIViewController{
    id<TTModel> _model;
}

@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UIImageView *imageBac;

@end
