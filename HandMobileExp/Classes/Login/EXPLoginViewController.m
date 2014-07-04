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



@interface EXPLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;


@end

@implementation EXPLoginViewController

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
    
    if([result isEqualToString:@"ok"]){
    
    [MMProgressHUD dismissWithSuccess:@"登录成功"];
        
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



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.view.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
		if ([obj isKindOfClass:[UITextField class]]) {
			[obj resignFirstResponder];
		}
	}];
}
@end
