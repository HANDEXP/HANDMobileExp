//
//  EXPLoadViewController.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-2.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPLoadViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "EXPUnlockViewController.h"

@interface EXPLoadViewController ()

@end

static NSString * loadingUrl = @"ios-backend-config-aries.xml";

@implementation EXPLoadViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(BOOL)hasServerAddress{
    NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:@"base_url_preference"];
    if (address.length==0||[address isEqualToString:@"http://"]) {
        return NO;
    }else {
        return YES;
    }
}



//设置用户选项
- (void)setupByPreferences
{
    NSString *baseURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"base_url_preference"];
    NSString *defaultApprove = [[NSUserDefaults standardUserDefaults] stringForKey:@"default_approve_preference"];
	if (!baseURL||!defaultApprove)
	{
        //从root文件读取配置
        NSString *settingsBundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Settings.bundle"];
        
        NSString *finalPath = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
        NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        
        NSArray *prefSpecifierArray = [settingsDict objectForKey:@"PreferenceSpecifiers"];
        
        NSMutableDictionary *appDefaults = [NSMutableDictionary dictionary];
        for (NSDictionary *prefItem in prefSpecifierArray)
        {
            if ([prefItem objectForKey:@"DefaultValue"] != nil) {
                [appDefaults setValue:[prefItem objectForKey:@"DefaultValue"]
                               forKey:[prefItem objectForKey:@"Key"]];
            }
        }
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
        [[NSUserDefaults standardUserDefaults] synchronize];
	}
}
-(void)Altertitle:(NSString *)Tile
     Alertmessage:(NSString *) message
{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:Tile
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定",nil];
    [alertView show];
    
}

#pragma alertDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self loadGodConfig];
}


-(NSString *)configURL{
     NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:@"base_url_preference"];
    return  [address stringByAppendingString :loadingUrl];
}

-(BOOL)pingStage1{
    BOOL success = false;
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc]initWithURL:url];
    [postRequest setHTTPMethod:@"HEAD"];
    [postRequest setTimeoutInterval:10];
    NSHTTPURLResponse* response = nil;
    NSData *resData = nil;
    
    resData= [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:nil];
    
    if (resData) {
        success = true;
    }
    
    return success;
}
-(void)showLoginView{
    NSLog(@"shhowloginview");
    
//    EXPLoginViewController *loginViewController = [[EXPLoginViewController alloc] initWithNibName:@"EXPLoginViewController" bundle:nil];
//    [self presentViewController:loginViewController animated:NO completion:nil];
    
    //[self presentModalViewController:loginViewController animated:YES];
    
    
    
    NSLog(@"xxxxxxxxxxxxxxxxx%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"password"]);
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"password"] isEqualToString:@""] && [[[NSUserDefaults standardUserDefaults ] valueForKey:@"gestureFlag"] isEqualToString:@"YES"]) {
        
        [self presentModalViewController:[[EXPUnlockViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
        
    }else{
    
        EXPLoginViewController *loginViewController = [[EXPLoginViewController alloc] initWithNibName:@"EXPLoginViewController" bundle:nil];
        [self presentModalViewController:loginViewController animated:YES];
    }
}

-(void)autologin
{
//    NSString *token = [[NSUserDefaults standardUserDefaults]stringForKey:@"Token"];
//    if (token) {
//
//    }else{
//
//   };
        //        HDLoginViewController * loginVCTL = [[[HDLoginViewController alloc]initWithNibName:@"HDLoginViewController" bundle:nil]autorelease];
        //        [UIApplication sharedApplication].delegate.window.rootViewController = loginVCTL;
        [self showLoginView];

}

-(void)loadGodConfig{
    
    UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    [imageview setImage:[UIImage imageNamed:@"loading"]];
    [self.view addSubview:imageview];
    
      BOOL hasAddress = [self hasServerAddress];
    if(!hasAddress){
        
        [self Altertitle:@"服务器地址未配置" Alertmessage:@"您还没有设置服务器地址。请回到主屏幕，打开“设置”，进入“移动商务”，在服务器地址一栏输入您公司所用的服务器地址"];
        
        
        
    }else{
        //开发发生请求
        NSString *fileURL = [NSString stringWithFormat:@"%@?t=%i",[self configURL],(int)[[NSDate date] timeIntervalSince1970]];
        NSURL *url = [NSURL URLWithString:fileURL];
        NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc]initWithURL:url];
        [postRequest setHTTPMethod:@"GET"];
        [postRequest setTimeoutInterval:30];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        void(^completionHandler)(NSURLResponse *response,
                                 NSData *data,
                                 NSError *error) = ^(NSURLResponse *response,
                                                     NSData *data,
                                                     NSError *error){
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            //count
            if (error) {
                NSInteger errorCode = [error code];
                if (errorCode == -1001||errorCode == -1003) {
                    //超时
                    //神一般的ping
                    BOOL ping1Success = [self pingStage1];
                    if (ping1Success) {
                        //百度ping通
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self Altertitle:@"网络异常" Alertmessage:@"您的手机当前可以上网，但无法连接到设定的服务器。请检查服务器地址是否正确。如果之前使用正常，有可能是服务器处于停机状态。如果您公司启用了VPN等安全接入方式，请检查是否已经成功连接VPN。"];
                        });
                    }else{
                        
                        //百度ping不通
                        dispatch_async(dispatch_get_main_queue(), ^{
                           [self Altertitle:@"没有可用的网络连接" Alertmessage:@"请检查您的设备是否有可用的网络连接。"];
                        });
                    }
                }else if(errorCode == -1004){
                    //没有网
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self Altertitle:@"没有可用的网络连接" Alertmessage:@"请检查您的设备是否有可用的网络连接。"];
                    });
                }else{
                    //未知错误，抛出原始错误信息
                    dispatch_async(dispatch_get_main_queue(), ^{
                         [self Altertitle:@"网络连接失败" Alertmessage:@"未知的错误原因"];
                    });
                    
                }
            }else{
                 NSInteger responseCode = [httpResponse statusCode];
                
                if (responseCode!=200) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self Altertitle:@"网络连接失败" Alertmessage:@"未知的错误原因"];
                    });
                }else {
                    BOOL writeSuccess = [data writeToFile:TTPathForDocumentsResource(@"ios-backend-config-aries.xml") atomically:YES];
                    if(writeSuccess){
                        EXPApplicationContext *appContext =  [EXPApplicationContext shareObject];
                        if([appContext configWithXmlPath:@"ios-backend-config-aries.xml"])
                        {
                            //                                                        //最终状态
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self dismissViewControllerAnimated:NO completion:^{}];
                                [self autologin];
                            });
                            
                        }else{
                            
 
                        }
                    }else{
                        
                        
                        
                    }
    
                }
            }
        
          
        };
        
        [NSURLConnection sendAsynchronousRequest:postRequest
                                           queue:queue
                               completionHandler:completionHandler];
        

}

    
    

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupByPreferences];
    [self loadGodConfig];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
