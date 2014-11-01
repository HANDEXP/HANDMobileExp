//
//  EXPDetailModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-13.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPSubmitDetailModel.h"
#import "TableDisplaySection.h"
#import "LMCellStypeItem_1.h"
#import "EXPLineModelDetailViewController.h"

@implementation EXPSubmitDetailModel
-(id)init{
    self = [super init];
    if(self){
        
        
        
    }
    
    return self;
}

- (void)load:(int)cachePolicy more:(BOOL)more{
    NSLog(@"hello");
   [self loadMethod:@"query" param:nil excute:@selector(QUERY_MOBILE_EXP_REPORT_LINE:)];
    
    
    
}

-(void)update:(NSArray *)param{
    [self loadMethod:@"update" param:param excute:@selector(UPDATE_MOBILE_EXP_REPORT_LINE_STATUS:recordList:)];
    
}

@end

@implementation EXPSubmitHttpModel

-(void)postLine:(NSDictionary *)parm{
    
    [self request:@"GET" param:parm url:[[EXPApplicationContext shareObject] keyforUrl:@"hmb_expense_detail_insert" ]];
    
}

- (void)upload:(NSDictionary *)param
      fileName:(NSString *)fileName
          data:(NSData *)data{
    
    
    [self uploadparam:param filedata:data filename:fileName mimeType:@"image/jpeg"
                  url:[[EXPApplicationContext shareObject] keyforUrl:@"hmb_expense_detail_insert" ]];
    
    
    
    
}

/////多张照片上传

- (void)upload:(NSDictionary *)param
      files:(NSMutableArray *)files
        {
    
    [self uploadparam:param files:files url:[[EXPApplicationContext shareObject] keyforUrl:@"hmb_expense_detail_insert" ]];
    

    
    
    
    
}




-(void)upload:(NSDictionary *)param
{
    [self param:param url:[[EXPApplicationContext shareObject] keyforUrl:@"hmb_expense_detail_insert"  ]];
    
}


@end

@implementation EXPSubmitDetailDataSource

-(id)init{
    
    self=[super init];
    if(self){
    
        //以后将改为由依赖注入
        EXPSubmitDetailModel * detailModel = [[EXPSubmitDetailModel alloc] init];
        self.model =detailModel;
    }
    return self;
}


#pragma -mark TTTableViewDataSource delegate
-(void)tableViewDidLoadModel:(UITableView *)tableView
{
    
    FMDataBaseModel * model = self.model;
    NSMutableSet * timeset = [[NSMutableSet alloc] init];
    
    NSMutableArray* sections = [NSMutableArray array];
    NSMutableArray* items = [NSMutableArray array];
    
    NSMutableArray *sectionSumMoeny = [[NSMutableArray alloc]init];
    NSString *sumMoney = [[NSString alloc]init];
    int count = 0;
    float sumMoneyInt = 0;
    
    for (  NSDictionary * record in  model.result){
        
        [timeset addObject:[record valueForKey:@"expense_date"]];
    }
    
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:NO]];
    NSArray *sortSetArray = [timeset sortedArrayUsingDescriptors:sortDesc];
    for(NSString * time in sortSetArray){
        
        sumMoneyInt = 0;
        for (  NSDictionary * record in  model.result){
            
            if ([time isEqualToString:[record objectForKey:@"expense_date"]]) {
                
                sumMoneyInt = sumMoneyInt + [[record objectForKey:@"expense_amount"]floatValue]
                *[[record objectForKey:@"expense_number"] integerValue];
                ;
            }
        }
        sumMoney = [NSString stringWithFormat:@"%.2f",sumMoneyInt];
        
        [sectionSumMoeny addObject:sumMoney];
        
    }
    
    
    for(NSString * time in sortSetArray){
        NSString *sumtempMoney = [NSString stringWithString:[sectionSumMoeny objectAtIndex:count]];
        count ++;
        
        TableDisplaySection * section =  [TableDisplaySection initwith:time item2:sumtempMoney];
        [sections addObject: section];
        NSMutableArray * item = [NSMutableArray array];
        for(NSDictionary * record in  model.result){
            
            if([time isEqualToString:[record valueForKey:@"expense_date"]]){
                LMCellStypeItem_1 * cellitem = [LMCellStypeItem_1 itemWithText:self selector:@selector(openURLForItem:)];
                cellitem.amount = [[record valueForKey:@"expense_amount"] floatValue]
                *[[record valueForKey:@"expense_number"] integerValue];
                ;
                cellitem.primary_id =  [record valueForKey:@"id"];
                
                
                NSString * exp_expense_type_desc = [record valueForKey:@"expense_type_desc"];
                NSString *  expense_class_desc = [record  valueForKey:@"expense_class_desc"];
                cellitem.expense_type_desc =  [[expense_class_desc stringByAppendingString:@">"] stringByAppendingString:exp_expense_type_desc];
                
                cellitem.line_desc =[record valueForKey:@"description"];
                
                cellitem.userInfo = @"EXPDetailLineGuider";
                [item addObject:cellitem];
                
                
            }
            
        }
        [items addObject:item];
        
        
    }
    
    self.sections = sections;
    self.items = items;

}



@end