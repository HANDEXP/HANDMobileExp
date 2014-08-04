//
//  EXPUnlockViewController.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-8-1.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPUnlockViewController.h"

#import "EXPHomeViewController.h"
#import "EXPFunctionListViewController.h"

@interface EXPUnlockViewController ()

//@property (nonatomic,assign) ePasswordSate state;

@property (nonatomic,copy) NSString* password;

@property (nonatomic,retain) UILabel* infoLabel;

@property (nonatomic,retain) MJPasswordView* passwordView;

@end

@implementation EXPUnlockViewController

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
    self.view.backgroundColor = [UIColor grayColor];
    
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 300, 30)];
    self.infoLabel.backgroundColor = [UIColor clearColor];
    self.infoLabel.textColor = [UIColor redColor];
    self.infoLabel.text = @"滑动图案已解锁";
    [self.view addSubview:self.infoLabel];
    
    CGRect frame = CGRectMake(20, 150, kPasswordViewSideLength, kPasswordViewSideLength);
    self.passwordView = [[MJPasswordView alloc] initWithFrame:frame];
    self.passwordView.delegate = self;
    [self.view addSubview:self.passwordView];
    
}

- (void)passwordView:(MJPasswordView*)passwordView withPassword:(NSString*)password
{
    
    if ([password isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"password"]])
    {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[EXPHomeViewController alloc] init]];
        
        EXPFunctionListViewController *leftMenuViewController = [[EXPFunctionListViewController alloc] init];
        // DEMORightMenuViewController *rightMenuViewController = [[DEMORightMenuViewController alloc] init];
        
        RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                        leftMenuViewController: leftMenuViewController
                                                                       rightMenuViewController:nil];
        sideMenuViewController.backgroundImage = [UIImage imageNamed:@"homeBg"];
        
        // sideMenuViewController.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.923 blue:0.409 alpha:0.340];
        [self presentModalViewController:sideMenuViewController animated:YES];
        
    }else{
                        UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"密码错误！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
