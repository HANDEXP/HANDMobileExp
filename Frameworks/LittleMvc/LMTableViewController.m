//
//  LMTableViewController.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-4.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableViewController.h"
#import "LMTableViewDelegate.h"

@interface LMTableViewController ()

@end

@implementation LMTableViewController
@synthesize tableView           = _tableView;
@synthesize dataSource          = _dataSource;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTModelViewController

/////////////调用datasource中的生成所需要的数据
- (void)didLoadModel:(BOOL)firstTime {
    [super didLoadModel:firstTime];
    [_dataSource tableViewDidLoadModel:_tableView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showModel:(BOOL)show {
    if (show) {
        [self updateTableDelegate];
        _tableView.dataSource = _dataSource;
        
    } else {
        _tableView.dataSource = nil;
    }
    [_tableView reloadData];
}





#pragma mark -
#pragma mark Private


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateTableDelegate {
    if (!self.tableView.delegate) {
        _tableDelegate = [self createDelegate];
        
        // You need to set it to nil before changing it or it won't have any effect
        _tableView.delegate = nil;
        _tableView.delegate = _tableDelegate;
    }
}

#pragma mark -
#pragma mark UIViewController

//可以在子类中重写该方法初始化话自己的tablieview
- (void)loadView {
    [super loadView];
    [self tableView];
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Public

-(UITableView *)tableView{
    if(nil == _tableView){
        _tableView= ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            

            tableView;
        });
        
    }
    [self.view addSubview:_tableView];
    
    return _tableView;
}


-(void)setTableView:(UITableView *)tableView{
    if(self.tableView != self.tableView){
        self.tableView = tableView;
        
        
        
    }
    
    
}



- (void)setDataSource:(id<LMTableViewDataSource>)dataSource {
    if (_dataSource != dataSource) {

        _dataSource = dataSource;
        _tableView.dataSource = nil;
        
        self.model = dataSource.model;
    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
    LMTableViewDelegate * delegate = [[LMTableViewDelegate alloc] initWithController:self];
    return  delegate;
}
@end
