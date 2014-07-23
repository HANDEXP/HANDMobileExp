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
@property NSInteger amount;
@property (nonatomic, strong)UILabel *sumLabel;
@property (strong, nonatomic)UILabel *sumMoneyLabel;


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


    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }

    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.title = @"报销创建";
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDetailPage:)];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.400 green:0.297 blue:0.199 alpha:0.840];
    
    self.sumMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(240.0, self.view.bounds.size.height * 0.10, 100.0, 50.0)];

    self.sumLabel = [[UILabel alloc]initWithFrame:CGRectMake(30.0, self.view.bounds.size.height * 0.10, 100.0, 50.0)];

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
       UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 100.0, self.view.bounds.size.width, self.view.bounds.size.height-100.0-64.0)];
        
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
    NSInteger sumMoneyInt = 0;
    for (  NSDictionary * record in  model.result){
        
        
        
        sumMoneyInt = sumMoneyInt + [[record objectForKey:@"expense_amount"]intValue];
    }
    
    NSString *sumMoney = [NSString stringWithFormat:@"¥%d",sumMoneyInt];
    
    
    self.sumLabel.text = @"总计：";
    
    
    self.sumMoneyLabel.text = sumMoney;
    
    [self.view addSubview:self.sumLabel];
    [self.view addSubview:self.sumMoneyLabel];
    
    
}
@end
