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
#import "EXPLoginModel.h"
#import "EXPLoginViewController.h"

@interface EXPUnlockViewController (){
    
        EXPLoginModel *loginmodel;
}

//@property (nonatomic,assign) ePasswordSate state;

@property (nonatomic,copy) NSString* password;

@property (nonatomic,retain) UILabel* infoLabel;

@property (nonatomic,retain) MJPasswordView* passwordView;

@property (nonatomic,strong)UILabel * otherWayLbl;

@end

@implementation EXPUnlockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        loginmodel = [[EXPLoginModel alloc] init];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView * backgroud = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gesture"]];
    
    [self.view addSubview:backgroud];
    
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/6, 300, 30)];
    self.infoLabel.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/6);
    self.infoLabel.textAlignment =  NSTextAlignmentCenter;

    
    self.infoLabel.backgroundColor = [UIColor clearColor];
    self.infoLabel.textColor = [UIColor whiteColor];
    self.infoLabel.text = @"请绘制解锁图案";
    [self.view addSubview:self.infoLabel];
    
    CGRect frame = CGRectMake(20, 150, kPasswordViewSideLength, kPasswordViewSideLength);
    self.passwordView = [[MJPasswordView alloc] initWithFrame:frame];
    
    self.passwordView.delegate = self;
    [self.view addSubview:self.passwordView];
    
    
    self.otherWayLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/6*5,300,30)];
    self.otherWayLbl.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/6*5);
    self.otherWayLbl.textAlignment = NSTextAlignmentCenter;
    
    self.otherWayLbl.backgroundColor = [UIColor clearColor];
    self.otherWayLbl.textColor = [UIColor whiteColor];
    self.otherWayLbl.text= @"登录其他用户";
    [self.view addSubview:self.otherWayLbl];
    
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goLogin)];
    self.otherWayLbl.userInteractionEnabled = YES;
    [self.otherWayLbl addGestureRecognizer:gesture];
    
    
                               
    
}

- (void)passwordView:(MJPasswordView*)passwordView withPassword:(NSString*)password
{
    
    if ([password isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"password"]])
    {
        NSString  * userpassword =  [[NSUserDefaults standardUserDefaults] valueForKey:@"userpassword"];
        NSString * username = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
        NSDictionary *param = @{@"user_name" : username,
                                @"user_password" : userpassword,
                                @"device_type" : @"iphone",
                                @"push_token" : @"-1",
                                @"device_Id" : @"-1"
                                };
        
        
        //初始化model
        [loginmodel.delegates addObject:self];
        loginmodel.tag = @"login";
        [loginmodel load:param];
        
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

#pragma gesture
-(void)goLogin
{
    
    EXPLoginViewController *loginViewController = [[EXPLoginViewController alloc] initWithNibName:@"EXPLoginViewController" bundle:nil];
    [self presentModalViewController:loginViewController animated:YES];
}

#pragma private
-(void)functionListShow{
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[EXPHomeViewController alloc] init]];
    
    EXPFunctionListViewController *leftMenuViewController = [[EXPFunctionListViewController alloc] init];
    // DEMORightMenuViewController *rightMenuViewController = [[DEMORightMenuViewController alloc] init];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController: leftMenuViewController
                                                                   rightMenuViewController:nil];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"homeBg"];
    
    // sideMenuViewController.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.923 blue:0.409 alpha:0.340];
    [self presentModalViewController:sideMenuViewController animated:YES];
}



#pragma  llmodel delegate
- (void)modelDidStartLoad:(EXPLoginModel *)model{
    
    
    
    if([model.tag isEqualToString:@"synchronization_url"] ){
        
        
    }else if([model.tag isEqualToString:@"login"]){
        
        [MMProgressHUD showWithTitle:@"Waiting" status:@"Loading"];
        
    }
    
}


- (void)modelDidFinishLoad:(EXPLoginModel *)model{
    
    
    if([model.tag isEqualToString:@"login"]){
        NSDictionary * head = [model.Json valueForKey:@"head"];
        NSString *result =  [head valueForKey:@"code"];
        NSLog(@"%@",result);
        if([result isEqualToString:@"ok"]){
            
            [MMProgressHUD dismissWithSuccess:nil title:@"登录成功" afterDelay:1];
            
            
   
            
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self functionListShow];
            });
            
            
            
            
        }else{
            
            [MMProgressHUD dismissWithError:@"账号或密码错误"];
            
        }
        
    }else if([model.tag isEqualToString:@"synchronization_url"]){
        
        NSMutableDictionary * result = (NSMutableDictionary *)model.Json;
        NSArray  * arr = [[result valueForKey:@"body"]valueForKey:@"list"];
        [[NSUserDefaults standardUserDefaults] setValue:arr forKey:@"expense_classes"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
    }
}

@end
