//
//  LMTableViewDelegate.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-5.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMTableViewController.h"

@interface LMTableViewDelegate : NSObject <UITableViewDelegate> {
    
     LMTableViewController*  _controller;
}
-(id)initWithController:(LMTableViewController *)controller;
@end
