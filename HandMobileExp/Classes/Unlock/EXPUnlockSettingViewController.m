//
//  EXPUnlockSettingViewController.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-8-1.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPUnlockSettingViewController.h"

@interface EXPUnlockSettingViewController ()<UIAlertViewDelegate>

@property (nonatomic,assign) ePasswordSate state;

@property (nonatomic,copy) NSString* password;

@property (nonatomic,retain) UILabel* infoLabel;

@property (nonatomic,retain) MJPasswordView* passwordView;

@end

@implementation EXPUnlockSettingViewController

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
	// Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:153.0f/255 alpha:1.000];
    UIImageView * backgroud = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gesture"]];
    
    [self.view addSubview:backgroud];
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 30)];
    [self.infoLabel setTextAlignment:NSTextAlignmentCenter];
    self.infoLabel.backgroundColor = [UIColor clearColor];
    self.infoLabel.textColor = [UIColor whiteColor];
    
    self.infoLabel.font = [UIFont fontWithName:@"" size:24.0];
    [self.view addSubview:self.infoLabel];
    
    CGRect frame = CGRectMake(20, 150, kPasswordViewSideLength, kPasswordViewSideLength);
    self.passwordView = [[MJPasswordView alloc] initWithFrame:frame];
    self.passwordView.delegate = self;
    [self.view addSubview:self.passwordView];
    
    [self updateInfoLabel];
}

- (void)updateInfoLabel
{
    NSString* infoText;
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"password"] != NULL) {
        NSLog(@"asfasfa %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"password"]);
    }
    
    switch (self.state)
    {
        case ePasswordUnset:
            infoText = @"请滑动九宫格，设置密码";
            break;
            
        case ePasswordRepeat:
            infoText = [NSString stringWithFormat:@"请再次输入刚才的密码"];
            break;
            
        case ePasswordExist:
            infoText = [NSString stringWithFormat:@"密码设置成功"];
            break;
            
        default:
            break;
    }
    
    self.infoLabel.text = infoText;
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)passwordView:(MJPasswordView*)passwordView withPassword:(NSString*)password
{
    switch (self.state)
    {
        case ePasswordUnset:
            [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            // self.password = password;
            self.state = ePasswordRepeat;
            break;
            
        case ePasswordRepeat:
            if ([password isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"password"]])
            {
                self.state = ePasswordExist;
                UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"密码设置成功！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [view show];
                
            }
            break;
            
        case ePasswordExist:
//            if ([password isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"password"]])
//            {
//                UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"密码正确！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [view show];
//            }
//            else
//            {
//                UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"密码错误，请重试！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [view show];
//            }
            
            break;
            
        default:
            break;
    }
    
    [self updateInfoLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
