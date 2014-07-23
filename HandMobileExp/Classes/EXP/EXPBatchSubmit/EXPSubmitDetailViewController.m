//
//  EXPDetailViewController.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-10.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPSubmitDetailViewController.h"
#import "LMCellStype.h"
#import "EXPLineModelDetailViewController.h"
#import "EXPSubmitDetailModel.h"
#import "AFNetRequestModel.h"

@interface EXPSubmitDetailViewController (){
    //点击代理
    EXPSubmitDelegate * delegate;
    
    //httpmodel
    EXPSubmitHttpModel * httpmodel;
    
    //组件
    UIButton  * btn;
}

@end

@implementation EXPSubmitDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //手动塞入依赖关系，以后会使用ioc
        EXPSubmitDetailDataSource * tv =  [[EXPSubmitDetailDataSource alloc] init];
        tv.DetailTvC = self;
        self.dataSource  = tv;
        //model
        httpmodel = [[EXPSubmitHttpModel alloc] init];
        [httpmodel.delegates addObject:self];
        
        
        //按钮
        btn  =  [[UIButton alloc] initWithFrame:CGRectMake(50, self.view.bounds.size.height *0.7, 220, 50)];
        [btn  setTitle:@"批量提交" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:0.780 green:0.805 blue:0.555 alpha:0.670]];
        [btn  addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:btn];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    [_tableView setEditing:YES animated:YES];
    //使能选中
    

    [_tableView setEditing:YES];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

    _tableView.allowsSelectionDuringEditing = YES;

    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.title = @"报销批量提交";
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

-(void)submit:(id *)sender
{
    
    EXPSubmitDetailDataSource * datasource = self.dataSource;
    FMDataBaseModel * model = datasource.model;
    
    for ( NSNumber * key    in  delegate.selectIndex){

        for (  NSDictionary * record in  model.result){
            NSNumber * recordId =  [record valueForKey:@"id"];
        
            if([recordId integerValue] == [key integerValue]){
                
                NSDictionary * param = @{
                                         @"expense_amount" : [record valueForKey:@"expense_amount"],
                                         @"expense_place" :[record valueForKey:@"expense_place"],
                                         @"expense_class_id" : [record valueForKey:@"expense_class_id"],
                                         @"expense_type_id"    : [record valueForKey:@"expense_type_id"] ,
                                         @"expense_date"    : [record valueForKey:@"expense_date"],
                                         @"description" : [record valueForKey:@"description"],
                                         @"local_id" : [record valueForKey:@"id"]
                                         };
                
                [httpmodel postLine:param];
            }
        
        

        }
    
    
    }
    
}

#pragma tableview

-(UITableView *)tableView{

    if(_tableView == nil){
    _tableView = ({
       UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height * 0.7)];
        
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



#pragma delegate
- (id<UITableViewDelegate>)createDelegate {
    delegate = [[EXPSubmitDelegate alloc] init];
    return delegate;
}



#pragma LMModelDelegate
-(void)modelDidFinishLoad:(id)model{
    NSString * className = [NSString stringWithUTF8String:object_getClassName(model)];
    
    if([className isEqualToString:@"EXPSubmitDetailModel"]){
        [super modelDidFinishLoad:model];
        
    }else if ([className isEqualToString:@"EXPSubmitHttpModel"]){
         
        
    }
    
    
    
}

@end
