//
//  EXPRateViewController.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-11-17.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPRateViewController.h"
#import "EXPRateModel.h"
#import "MMProgressHUD.h"
#import "LMAlertViewTool.h"
#import "LMRateTableCell.h"

@interface EXPRateViewController ()

@end

@implementation EXPRateViewController{
    
    UITableView * tableview;
    
    EXPRateModel * model;
    
    NSArray * rateData;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        model = [[EXPRateModel alloc] init];
        self.model  = model;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"选择汇率";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    tableview.tableFooterView = [[UIView alloc]init];
    tableview.tableHeaderView = [[UIView alloc]init];
    [self.view addSubview:tableview];
    
    
    
    tableview.delegate = self;
    
    [model load];

    
    
    // Do any additional setup after loading the view.
}

-(void)showLoad:(BOOL)flag{
    if(flag){
        //[MMProgressHUD showProgressWithStyle:MMProgressHUDProgressStyleLinear title:@"" status:@"loading"];
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
        
        [MMProgressHUD  showWithStatus:@"loading"];
    }else{
        
        [MMProgressHUD dismiss];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


///////////////uitableview delegate////////////
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   NSArray * data  =  [rateData objectAtIndex:indexPath.row];
    NSString * currency =  [data valueForKey:@"currency"];
    NSString * exchange_rate = [data valueForKey:@"exchange_rate"];
    NSNumber * rate = [NSNumber numberWithFloat:[exchange_rate floatValue]];
    
    [self.parent reloadRateCell:currency exchangeRate:rate];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

///////////////uitableview datasource//////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return rateData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMRateTableCell * cell = [[LMRateTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMRateTableCell"];
    
    NSArray * data = [rateData  objectAtIndex:indexPath.row];
    
    [cell.currency setText:[data valueForKey:@"currency"]];
    [cell.rate setText:[data valueForKey:@"exchange_rate"]];
    
    
    return cell;
    
    
    
}


///////////////model delegate
-(void)modelDidStartLoad:(id<TTModel>)model{
    
    [self showLoad:YES];
    
}


-(void)model:(id<TTModel>)model didFailLoadWithError:(NSError *)error
{
    
    [self showLoad:NO];
    [LMAlertViewTool showAlertView:@"提示" message:@"网络出现问题，无法获取汇率" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

-(void)modelDidFinishLoad:(id<TTModel>)_model{
    [self showLoad:NO];
    
    
    rateData = [[model.Json valueForKey:@"body"] valueForKey:@"list"];
    tableview.dataSource = self;
    [tableview reloadData];
    
    
    
    
    
    
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
