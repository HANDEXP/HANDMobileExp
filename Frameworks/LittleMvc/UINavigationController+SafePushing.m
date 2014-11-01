//
//  UINavigationController+SafePushing.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-10-31.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "UINavigationController+SafePushing.h"

@implementation UINavigationController (SafePushing)


- (id)navigationLock
{
    return self.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)navigationLock
{
    if (!navigationLock || self.topViewController == navigationLock)
        [self pushViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated navigationLock:(id)navigationLock
{
    if (!navigationLock || self.topViewController == navigationLock)
        return [self popToRootViewControllerAnimated:animated];
    return @[];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)navigationLock
{
    if (!navigationLock || self.topViewController == navigationLock)
        return [self popToViewController:viewController animated:animated];
    return @[];
}


@end
