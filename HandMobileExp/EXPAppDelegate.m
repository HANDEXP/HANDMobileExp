//
//  EXPAppDelegate.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-1.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPAppDelegate.h"
#import  "EXPLineModelDetailViewController.h"
#import "EXPLoadViewController.h"
#import "EXPLineModelDetailViewController.h"
#import "EXPChartViewController.h"

#import "EXPUnlockSettingViewController.h"

        @implementation EXPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //register notification
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
    
    //create databasetable if not create
    [[HDCoreStorage shareStorage]excute:@selector(SQLCreatTable:) recordList:nil];
    
    
    if (kCFCoreFoundationVersionNumber > kCFCoreFoundationVersionNumber_iOS_6_1) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[EXPLoadViewController alloc] initWithNibName:nil bundle:nil];
   
//    self.window.rootViewController = [[EXPUnlockSettingViewController alloc] initWithNibName:nil bundle:nil];

    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
  //  NSLog(@"in applicationWillResignActive");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
       NSLog(@"in applicationDidEnterBackground");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //NSLog(@"in applicationDidBecomeActive");

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//获取token成功,格式化token,放入用户设置中
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //get the deivcetoken
    NSLog(@"My token is: %@", deviceToken);
    
    //format token
    NSString *tokenWithBlank = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *tokenWithoutBlank = [tokenWithBlank stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //save deviceToken to userDefaults
    [[NSUserDefaults standardUserDefaults] setValue:tokenWithoutBlank forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] setValue:tokenWithoutBlank forKey:@"device_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
