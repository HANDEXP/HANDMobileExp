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
#import "YFJLeftSwipeDeleteTableView.h"

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
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.561 green:0.380 blue:0.201 alpha:1.000];
    
    self.sumMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(160.0, self.view.bounds.size.height * 0.05, 150.0, 50.0)];
    
    self.sumMoneyLabel.font = [UIFont fontWithName:@"Helvetica" size:25.0f];
    self.sumMoneyLabel.textAlignment = NSTextAlignmentRight;
    
    self.sumMoneyLabel.textColor = [UIColor whiteColor];
    self.sumLabel = [[UILabel alloc]initWithFrame:CGRectMake(30.0, self.view.bounds.size.height * 0.05, 100.0, 50.0)];
    self.sumLabel.textColor = [UIColor whiteColor];
    self.sumLabel.font = [UIFont fontWithName:@"Helvetica" size:25.0f];
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
       UITableView * tableView = [[YFJLeftSwipeDeleteTableView alloc]initWithFrame:CGRectMake(0.0, 100.0, self.view.bounds.size.width, self.view.bounds.size.height-100.0)];
        tableView.backgroundView.backgroundColor = [UIColor whiteColor];
        tableView.backgroundColor = [UIColor colorWithRed:0.947 green:0.940 blue:0.831 alpha:1.000];
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
    float sumMoneyInt = 0;
    for (  NSDictionary * record in  model.result){
        
        
        
        sumMoneyInt = sumMoneyInt + [[record objectForKey:@"expense_amount"]intValue];
    }
    
    NSString *sumMoney = [NSString stringWithFormat:@"¥%2.2f",sumMoneyInt];
    
    
    self.sumLabel.text = @"总计：";
    
    
    self.sumMoneyLabel.text = sumMoney;
    
    [self.view addSubview:self.sumLabel];
    [self.view addSubview:self.sumMoneyLabel];
    
    
}
@end
