//
//  EXPFunctionListViewController.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-4.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPFunctionListViewController.h"

@interface EXPFunctionListViewController ()

@end

@implementation EXPFunctionListViewController

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

    
    //暂时不是用ioc反转
    EXPFunctionListDatasource * datasource = [[EXPFunctionListDatasource alloc] init];
    datasource.ViewController = self;
    self.dataSource =datasource;
    
    
    [self.view addSubview:self.tableview];
    
    
}

-(UITableView *)tableView{
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 3.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:_tableView];
    return nil;
}


#pragma mark LLMODEL Delegate
- (void)modelDidFinishLoad:(AFNetRequestModel *)model{
    //必须调用父类的完成事件
    [super modelDidFinishLoad:model];
    NSMutableDictionary * result = model.Json;

    NSArray *list = [[result valueForKey:@"body"]valueForKey:@"list"];
    NSArray *items  = [list[0] valueForKey:@"items"];
    NSLog(@"%d",[items  count]);
    for(int i =0;i< [items count];i++){
        NSLog(@"%@",[items[i] valueForKey:@"url"]);
    }
//    NSLog(@"%@",url);
}

@end
