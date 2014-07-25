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
#import "MMProgressHUDWindow.H"

@interface EXPSubmitDetailViewController (){
    //点击代理
    EXPSubmitDelegate * delegate;
    
    //httpmodel
    EXPSubmitHttpModel * httpmodel;
    
    //dataBaseModel
    EXPSubmitDetailModel * datamodel;
    
    //组件
    UIButton  * btn;
    
    
    
    
    ////
    NSMutableArray * _tagArray;
    
    //
    int needUploadRecord;
    int selectRecord;
    
    //
    BOOL httpFaild;
    
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
        datamodel = tv.model;
        
        httpmodel = [[EXPSubmitHttpModel alloc] init];
        [httpmodel.delegates addObject:self];
        

        //
        _tagArray = [[NSMutableArray alloc] init];
        needUploadRecord = 0;
        selectRecord = 0;
        httpFaild = NO;
        

        UIImage *checkList = [UIImage imageNamed:@"submit"];
        self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithImage:checkList style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
        
        //按钮
//        btn  =  [[UIButton alloc] initWithFrame:CGRectMake(50, self.view.bounds.size.height *0.7, 220, 50)];
//        [btn  setTitle:@"批量提交" forState:UIControlStateNormal];
//        [btn setBackgroundColor:[UIColor colorWithRed:0.780 green:0.805 blue:0.555 alpha:0.670]];
//        [btn  addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchDown];
//        [self.view addSubview:btn];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    //按钮
    btn  =  [[UIButton alloc] initWithFrame:CGRectMake(50, self.view.bounds.size.height *0.7, 220, 50)];
    [btn  setTitle:@"批量提交" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:0.780 green:0.805 blue:0.555 alpha:0.670]];
    [btn  addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    
    [_tableView setEditing:YES animated:YES];
    //使能选中
    
    
    [_tableView setEditing:YES];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    
    //important 解决7.1超过边框问题 
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
                
                
                NSDictionary * _tag = @{@"local_id" : [record valueForKey:@"id"],
                                        @"item1"    : [record valueForKey:@"item1"]
                                        };
                
                selectRecord++;
                
                NSData * data =    [record valueForKey:@"item1"];
                if( data.length !=0){
                    needUploadRecord++;
                }
                
                
                [_tagArray addObject:_tag];
                
                [httpmodel postLine:param];
                
                
            }
            
        }
        
        
    }
    
}

#pragma tableview

-(UITableView *)tableView{
    
    if(_tableView == nil){
//<<<<<<< Updated upstream
//        _tableView = ({
//            UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height * 0.7)];
//            
//            tableView.backgroundColor = [UIColor colorWithRed:0.876 green:0.874 blue:0.760 alpha:1.0];
//            tableView.backgroundView = nil;
//            tableView.tableFooterView = [[UIView alloc]init];
//            tableView.tableHeaderView = [[UIView alloc]init];
//            tableView;
//        });
//=======
    _tableView = ({
       UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
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
-(void)modelDidStartLoad:(id<TTModel>)model{
    
    NSString * className = [NSString stringWithUTF8String:object_getClassName(model)];
    if([className isEqualToString:@"EXPSubmitDetailModel"]){
        
        
    }else if([className isEqualToString:@"EXPSubmitHttpModel"]){
        MMProgressHUD.presentationStyle =MMProgressHUDPresentationStyleDrop;
        [datamodel load:0 more:0];
        
        [MMProgressHUD showWithTitle:nil status:@"upload"];
        
    }
    
}

-(void)modelDidFinishLoad:(id)model{
    NSString * className = [NSString stringWithUTF8String:object_getClassName(model)];
    
    if([className isEqualToString:@"EXPSubmitDetailModel"]){
        [super modelDidFinishLoad:model];
        
    }else if ([className isEqualToString:@"EXPSubmitHttpModel"]){
        
        EXPSubmitHttpModel *__model = model;
        NSLog(@"%@",__model.Json);
        
        NSDictionary * body = [__model.Json valueForKey:@"body"];
        
        
        
        NSNumber * pkvalue = [body valueForKey:@"expense_detail_id"];
        NSNumber * local_id = [body valueForKey:@"local_id"];
        NSString * source_type = @"hmb_expense_detail";
        
        
        
        NSDictionary * currentTag;
        for(NSDictionary * _tag in _tagArray){
            NSNumber *_local_id = [_tag valueForKey:@"local_id"];
            if([_local_id integerValue] == [local_id integerValue]){
                
                NSData * imgData = [_tag valueForKey:@"item1"];
                
                if  (imgData.length !=0){
                    //进行发送图片
                    NSDictionary * param = @{@"pkvalue" : pkvalue,
                                             @"source_type" : source_type
                                             };
                    
                    EXPSubmitHttpModel *  _httpmodel = [[EXPSubmitHttpModel alloc] init];
                    [_httpmodel.delegates addObject:self];
                    
                    _httpmodel.info = _local_id;

                    [_httpmodel upload:param fileName:@"upload.jpg" data:imgData];
                }else {
                    //不需要上传则直接更新表状态
                    NSDictionary * param = @{
                                             @"id": _local_id,
                                             @"local_status": @"upload"
                                             };
                    NSArray * records = @[param];
                    [datamodel update:records];
                    
                    
                }
                
                
                
                break;
                
                
            }
            
            
        }
        
        //每次返回成功后都将需要提交的数据标识减少一
        selectRecord --;
        
        
        if(selectRecord == 0 && needUploadRecord ==0){
            //认为结束
            MMProgressHUD.presentationStyle =MMProgressHUDPresentationStyleNone;
            [MMProgressHUD dismiss];
            [self reload];
        
        }
        
        
        
    }
    
    
    
    
    
}

-(void)model:(id<TTModel>)model didFailLoadWithError:(NSError *)error{
    EXPSubmitHttpModel *__model =   model;
    //处理超时异常
    NSLog(@"%d",error.code);
     NSLog(@"%@",__model.tag);
    if(error.code == -1001 || error.code == -1004 || error.code == -1009){
        if(!httpFaild){
            httpFaild = YES;
            [MMProgressHUD dismiss];
            [LMAlertViewTool showAlertView:@"提示" message:@"服务器链接超时请重新提交" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        }
    }else if(error.code == 3840 || error.code == -1016){
        //todo 3804为接口返回数据不为json格式错误，现在默认情况认为返回这个错误就是成功
        
        NSDictionary * param = @{
                                 @"id": __model.info,
                                 @"local_status": @"upload"
                                 };
        NSArray * records = @[param];
        [datamodel update:records];
        
        needUploadRecord--;
        if(selectRecord == 0 && needUploadRecord ==0){
            //认为结束
            MMProgressHUD.presentationStyle =MMProgressHUDPresentationStyleNone;
            [MMProgressHUD dismiss];
            [self reload];
            
        }
        
        
    }
}


@end
