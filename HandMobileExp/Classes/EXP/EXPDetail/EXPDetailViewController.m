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
    [self.navigationController pushViewController:[[EXPLineModelDetailViewController alloc]initWithNibName:nil bundle:nil] animated:YES];
}


- (void)returnHomePage:(id *)sender
{

    [self.navigationController popViewControllerAnimated:YES];
}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 3;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    
//    return 2;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //  EXPLineCell *cell = [tableView registerNib:[UINib nibWithNibName:@"EXPLineCell" bundle:Nil] forCellReuseIdentifier:CellIdentifier];
//    
//    
//    EXPLineCell *cell = (EXPLineCell *)[tableView dequeueReusableCellWithIdentifier:@"EXPLineCell"];
//    
//    if (cell == nil) {
//        
//        
//        cell = [[EXPLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EXPLineCell"];
//        
//        cell.backgroundColor = [UIColor clearColor];
//        cell.backgroundView.backgroundColor = [UIColor clearColor];
//        
//        
//    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
////    
////    if (indexPath.section == 0 && indexPath.row == 0) {
////        cell.firstLabel.text = @"总金额";
////        cell.secondLabel.text = @"$100,000,000";
////    }
//    cell.firstLabel.text = @"餐饮";
//    cell.secondLabel.text = @"$100";
//    cell.thirdLabel.text = @"备注 | 无";
//    return cell;
//    
//    
//    
//    // Configure the cell...
//    
//    return cell;
//}
//

//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 46;
//}

-(UITableView *)tableView{
    
    _tableView = ({
       UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 100.0, self.view.bounds.size.width, self.view.bounds.size.height-150.0)];
        
        tableView.backgroundColor = [UIColor colorWithRed:0.876 green:0.874 blue:0.760 alpha:1.00];
        tableView.backgroundView = nil;
        tableView.tableFooterView = [[UIView alloc]init];
        tableView.tableHeaderView = [[UIView alloc]init];
        tableView;
    });
    [self.view addSubview:_tableView];
    return _tableView;
}


#pragma LMModelDelegate
-(void)modelDidFinishLoad:(FMDataBaseModel *)model{
    NSLog(@"hello");
     [super modelDidFinishLoad:model];

    
    
}
@end
