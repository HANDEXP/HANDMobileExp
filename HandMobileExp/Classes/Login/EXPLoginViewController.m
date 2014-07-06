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



@interface EXPLoginViewController ()<UITextFieldDelegate>{
    
  
}

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;


@end

@implementation EXPLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [@[_passwordTF,_userNameTF] enumerateObjectsUsingBlock:^(UITextField *obj, NSUInteger idx, BOOL *stop) {
        [obj.layer setBorderWidth:2];
        [obj.layer setBorderColor:[UIColor colorWithRed:0.235 green:0.627 blue:0.275 alpha:1.000].CGColor];
        obj.delegate = self;
    }];
    

    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TTMODEL
- (void)modelDidStartLoad:(id<TTModel>)model{
    CGFloat red =  arc4random_uniform(255)/255.f;
    CGFloat blue = arc4random_uniform(256)/255.f;
    CGFloat green = arc4random_uniform(256)/255.f;
    
    CGColorRef color = CGColorRetain([UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor);
    
    [[[MMProgressHUD sharedHUD] overlayView] setOverlayColor:color];
    
    CGColorRelease(color);
    
    [MMProgressHUD showWithTitle:@"Waiting" status:@"Loading"];
    
    
}


- (void)modelDidFinishLoad:(AFNetRequestModel *)model{
    
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
    
    NSDictionary *param = @{@"user_name" : self.userNameTF.text,
                            @"user_password" : self.passwordTF.text,
                            @"device_type" : @"iphone",
                            @"push_token" : @"-1",
                            @"device_Id" : @"-1"
                            };

//    BOOL autodismiss = YES;
    

    
//    if (autodismiss == YES) {
//        double delayInSeconds = 2.5;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            [MMProgressHUD dismissWithSuccess:@"Success!"];
//        });
//    }
    //初始化model
    EXPLoginModel *loginmodel = [[EXPLoginModel alloc] init];
    [self setModel:loginmodel];
    [loginmodel load:param];
}

-(void)functionListShow{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[DEMOFirstViewController alloc] init]];
    EXPFunctionListViewController *leftMenuViewController = [[EXPFunctionListViewController alloc] init];
    DEMORightMenuViewController *rightMenuViewController = [[DEMORightMenuViewController alloc] init];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController: leftMenuViewController
                                                                   rightMenuViewController:rightMenuViewController];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    [self presentModalViewController:sideMenuViewController animated:YES];
}

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
