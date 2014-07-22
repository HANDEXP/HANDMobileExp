//
//  EXPDetailViewController.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-10.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPDetailViewController.h"
#import "LMCellStype.h"
#import "EXPLineModelDetailViewController.h"
#import "EXPDetailModel.h"
#import "AFNetRequestModel.h"

@interface EXPDetailViewController ()

@end

@implementation EXPDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //手动塞入依赖关系，以后会使用ioc
        EXPDetailDataSource * tv =  [[EXPDetailDataSource alloc] init];
        tv.DetailTvC = self;
        self.dataSource  = tv;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    
    

    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.title = @"报销创建";
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDetailPage:)];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.400 green:0.297 blue:0.199 alpha:0.840];
    
    



}

#pragma button delegate
- (void)addDetailPage:(id *)sender
{
   EXPLineModelDetailViewController *detail =  [[EXPLineModelDetailViewController alloc]initWithNibName:nil bundle:nil];
    detail.detailList = self;
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)returnHomePage:(id *)sender
{

    [self.navigationController popViewControllerAnimated:YES];
}



-(UITableView *)tableView{

    if(_tableView == nil){
    _tableView = ({
       UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 100.0, self.view.bounds.size.width, self.view.bounds.size.height-150.0)];
        
        tableView.backgroundColor = [UIColor colorWithRed:0.876 green:0.874 blue:0.760 alpha:1.0];
        tableView.backgroundView = nil;
        tableView.tableFooterView = [[UIView alloc]init];
        tableView.tableHeaderView = [[UIView alloc]init];
        tableView;
    });
    }
    
    [self.view addSubview:_tableView];
    return _tableView;
}


#pragma LMModelDelegate
-(void)modelDidFinishLoad:(FMDataBaseModel *)model{

     [super modelDidFinishLoad:model];

    
    
}
@end
