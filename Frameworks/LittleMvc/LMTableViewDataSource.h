//
//  LMTableViewDataSource.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-5.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "LMModel.h"
#import "LMTableImageItem.h"

@protocol LMTableViewDataSource <UITableViewDataSource,UISearchDisplayDelegate>

@property (nonatomic, retain) id<TTModel> model;

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object;
- (id)tableView:(UITableView*)tableView objectForRowAtIndexPath:(NSIndexPath*)indexPath;
- (void)tableView:(UITableView*)tableView cell:(UITableViewCell*)cell willAppearAtIndexPath:(NSIndexPath*)indexPath;
- (void)tableViewDidLoadModel:(UITableView*)tableView;

@end


@interface LMTableViewDataSource : NSObject <LMTableViewDataSource>

@property (nonatomic, retain) id<TTModel> model;

@end
