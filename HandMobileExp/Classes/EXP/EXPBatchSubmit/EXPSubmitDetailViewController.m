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
    
    //
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
    
    //[_tableView setEditing:YES animated:YES];
    //使能选中
    
    
    [_tableView setEditing:YES];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    
    //important 解决7.1超过边框问题 
    _tableView.allowsSelectionDuringEditing = YES;
    
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.title = @"批量上传";
    self.view.backgroundColor = [UIColor colorWithRed:0.400 green:0.297 blue:0.199 alpha:0.840];
    
    
    
    
    
    
    
}

#pragma button delegate
- (void)addDetailPage:(id *)sender
{
    EXPLineModelDetailViewController *detail =  [[EXPLineModelDetailViewController alloc]initWithNibName:nil bundle:nil];
    detail.detailList = self;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma private
- (void)returnHomePage:(id *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submit:(id *)sender
{
    
    EXPSubmitDetailDataSource  * datasource = self.dataSource;
    FMDataBaseModel * model = datasource.model;
    
    
    
    for ( NSNumber * key    in  delegate.selectIndex){
        
        for (  NSDictionary * record in  model.result){
            
            NSNumber * recordId =  [record valueForKey:@"id"];
            
            if([recordId integerValue] == [key integerValue]){
                
               NSNumber * expense_amount=  [record valueForKey:@"expense_amount"];
                NSString *  expenseAmount = [NSString stringWithFormat:@"%.2f",[expense_amount floatValue]];
                NSNumber  * exchange_rate = [record valueForKey:@"exchangeRate"];
                
                 NSString *  exchangeRate = [NSString stringWithFormat:@"%.2f",[exchange_rate floatValue]];
                
                NSDictionary * param = @{
                                         @"expense_amount" : expenseAmount,
                                         @"expense_number" : [record valueForKey:@"expense_number"],
                                         @"expense_place" :[record valueForKey:@"expense_place"],
                                         @"expense_class_id" : [record valueForKey:@"expense_class_id"],
                                         @"expense_type_id"    : [record valueForKey:@"expense_type_id"] ,
                                         @"expense_date"    : [record valueForKey:@"expense_date"],
                                         @"expense_date_to"    : [record valueForKey:@"expense_date_to"],
                                         @"description" : [record valueForKey:@"description"],
                                         @"local_id" : [record valueForKey:@"id"],
                                         @"currency_code" : [record valueForKey:@"currency"],
                                         @"exchange_rate" : exchangeRate
                                         
                                         
                                         };
                
                
                
                selectRecord++;
                
                NSData * data =    [record valueForKey:@"item1"];
                if( data.length !=0){
//                    [httpmodel upload:param fileName:@"upload.jpg" data:data];
                    NSMutableArray * files = [[NSMutableArray alloc] init];
                    
                    for(int i = 0;i< 9;i++){
                        NSString * keyItem = @"item";
                        NSString * mimeType =  @"image/jpeg";
                        keyItem = [keyItem stringByAppendingFormat:@"%d",i+1];
                        NSData * data = [record valueForKey:keyItem];
                        if(data !=nil && data.length !=0){
                            NSString * fileName =@"upload";
                            fileName =   [fileName stringByAppendingFormat:@"%d.jpg",i];
                            
                            NSDictionary * file = @{@"mimeType": mimeType,
                                                    @"filename" :fileName,
                                                    @"filedata" :data
                                                    
                                                    
                                                    };
                            
                            [files addObject:file];
                            
                           
                            
                        }
                    
                    }
                    
                    [httpmodel upload:param files:files];
                    
                    
                }else{
                    [httpmodel upload:param];
                    
                }
                
            
                
                
                
            }
            
        }
        
        
    }
    
}

#pragma tableview

-(UITableView *)tableView{
    
    if(_tableView == nil){

    _tableView = ({
       UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
//        tableView.backgroundColor = [UIColor colorWithRed:0.876 green:0.874 blue:0.760 alpha:1.0];
        tableView.backgroundColor = [UIColor whiteColor];
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

#pragma model delegate
-(void)modelDidFinishLoad:(id)model{
    NSString * className = [NSString stringWithUTF8String:object_getClassName(model)];
    
    if([className isEqualToString:@"EXPSubmitDetailModel"]){
        //刷新tableview
        [super modelDidFinishLoad:model];
        
    }else if ([className isEqualToString:@"EXPSubmitHttpModel"]){
        
        EXPSubmitHttpModel *__model = model;
        NSLog(@"%@",__model.Json);
        
        NSDictionary * body = [__model.Json valueForKey:@"body"];
        NSDictionary * head = [__model.Json valueForKey:@"head"];
        
        NSString * result =[head valueForKey:@"code"];
        
        
        NSNumber * local_id = [body valueForKey:@"local_id"];

        
        if([result isEqualToString:@"success"]){

                    //不需要上传则直接更新表状态
                NSDictionary * param = @{
                                @"id": local_id,
                                @"local_status": @"upload"
                                };
                NSArray * records = @[param];
                [datamodel update:records];
        
            }else if ([result isEqualToString:@"failure"]){
                
                
            
            }

                    

        
        //每次返回成功后都将需要提交的数据标识减少一
        selectRecord --;
        
        
        if(selectRecord == 0 && !httpFaild ){
            //认为结束
            MMProgressHUD.presentationStyle =MMProgressHUDPresentationStyleNone;
            
              //重置标志位
            httpFaild = NO;
            selectRecord = 0;
                        [delegate.selectIndex removeAllObjects];
            
            [MMProgressHUD dismiss];
            [self reload];
        //选中标记为0，而且网络请求失败过
        }else if(selectRecord == 0 && httpFaild){
              //重置标志位
            selectRecord = 0;
            httpFaild = NO;
                        [delegate.selectIndex removeAllObjects];
            
            [MMProgressHUD dismiss];
            [self reload];
        }
        
        
        
    }
    
    
    
    
    
}

-(void)model:(id<TTModel>)model didFailLoadWithError:(NSError *)error{
        EXPSubmitHttpModel *__model =   model;
            //错误异常处理
    
            //每次返回失败后都将需要提交的数据标识减少一
            selectRecord --;
            httpFaild = YES;
            [delegate.selectIndex removeAllObjects];
    
            //错误只提醒一次,当选择的标记全部返回为止
            if(selectRecord ==0){
            [MMProgressHUD dismiss];
                [self reload];
                //重置标志位
                httpFaild = NO;
                selectRecord = 0;
            [LMAlertViewTool showAlertView:@"提示" message:@"网络出现问题，请检查网络后重新提交" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            }
    
}


@end
