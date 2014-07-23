//
//  ViewController.m
//  Login
//
//  Created by Tracy－jun on 14-7-1.
//  Copyright (c) 2014年 王俊. All rights reserved.
//

#import "EXPLoginViewController.h"
#import "MMProgressHUD.h"
#import "MMProgressHUDOverlayView.h"
#import "EXPLineModelDetailViewController.h"



@interface EXPLoginViewController ()<UITextFieldDelegate>{
    EXPLoginModel *loginmodel;
    
}
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic)IBOutlet UIImageView *bgImageView;

@end

@implementation EXPLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        loginmodel = [[EXPLoginModel alloc] init];
        [self setModel:loginmodel];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [@[_passwordTF,_userNameTF] enumerateObjectsUsingBlock:^(UITextField *obj, NSUInteger idx, BOOL *stop) {
        
        obj.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.090];
        obj.delegate = self;
    }];
    
    
    UIImage *bgImage = [UIImage imageNamed:@"loginBg"];
    self.bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.bgImageView.image = bgImage;
    self.bgImageView.center = self.view.center;
    [self.view insertSubview:self.bgImageView atIndex:0];
    
    [self.loginButton.layer setCornerRadius:6.0f];
    
    
    //初始化缓存账户
    self.userNameTF.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    
    //同步类型数据
    loginmodel.tag = @"synchronization_url";
    [loginmodel loadExpenseType];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TTMODEL
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

#pragma logindelegate
- (IBAction)loginAction:(id)sender {
    
    if (self.userNameTF.text.length == 0) {
        [self lockAnimationForView:self.userNameTF];
        return ;
    }
    if (self.passwordTF.text.length == 0) {
        [self lockAnimationForView:self.passwordTF];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:self.userNameTF.text forKey:@"username"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSDictionary *param = @{@"user_name" : self.userNameTF.text,
                            @"user_password" : self.passwordTF.text,
                            @"device_type" : @"iphone",
                            @"push_token" : @"-1",
                            @"device_Id" : @"-1"
                            };
    
    
    //初始化model
    
    loginmodel.tag = @"login";
    [loginmodel load:param];
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

#pragma textfieldDelegate
-(void)lockAnimationForView:(UIView*)view
{
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-10, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 150.0)+180;//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    
    if(offset > 0 )
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    NSLog(@"%f",self.view.frame.origin.y);
    [UIView commitAnimations];
    
    
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return 1;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.view.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
		if ([obj isKindOfClass:[UITextField class]]) {
            self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
			[obj resignFirstResponder];
		}
	}];
    
}
@end
