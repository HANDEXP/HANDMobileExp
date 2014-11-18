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
        //暂时不是用ioc反转
        EXPFunctionListDatasource * datasource = [[EXPFunctionListDatasource alloc] init];
        datasource.ViewController = self;
        self.dataSource =datasource;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    
    
    UILabel *handLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0, self.view.bounds.size.height*0.95, 300.0, 20.0)];
    handLabel.text = @"汉得移动报销/Better Experience";
    handLabel.font = [UIFont systemFontOfSize:11.0f];
    handLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:handLabel];
    
    [self.view addSubview:self.tableview];
    
    
}

-(UITableView *)tableView{
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height/2, self.view.frame.size.width, 50 * 5) style:UITableViewStylePlain];
    
        tableView.center =  CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        
        
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
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
    EXPFunctionListModel * Expmodel = model;
    if([Expmodel.tag isEqualToString:@"SyncGuider"]){
        
        NSMutableDictionary * result = (NSMutableDictionary *)model.Json;
        NSArray  * arr = [[result valueForKey:@"body"]valueForKey:@"list"];
        
        [[NSUserDefaults standardUserDefaults] setValue:arr forKey:@"expense_classes"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        
        
        //必须调用父类的完成事件
        [super modelDidFinishLoad:model];
        
        NSMutableDictionary * result = model.Json;
        //数据储存在上下文中

        
        NSArray *list = [[result valueForKey:@"body"]valueForKey:@"list"];
        NSArray *items  = [list[0] valueForKey:@"items"];
        
        for(int i =0;i< [items count];i++){
            NSLog(@"%@",[items[i] valueForKey:@"url"]);
        }
        
    }
}

@end
