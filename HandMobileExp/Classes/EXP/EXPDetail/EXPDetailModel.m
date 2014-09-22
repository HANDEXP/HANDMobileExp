//
//  EXPDetailModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-13.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPDetailModel.h"
#import "TableDisplaySection.h"
#import "LMCellStypeItem.h"
#import "EXPLineModelDetailViewController.h"



@interface EXPDetailModel ()



@end

@implementation EXPDetailModel
-(id)init{
    self = [super init];
    if(self){
        
        
        
    }
    
    return self;
}




- (void)load:(int)cachePolicy more:(BOOL)more{
    //NSLog(@"hello");

    
    [self loadMethod:@"query" param:nil excute:@selector(QUERY_MOBILE_EXP_REPORT_LINE:param:)];
    
}

- (void)deleteCell:(NSArray *)dictionary
{
    [self loadMethod:@"delete" param:dictionary excute:@selector(DELETE_MOBILE_EXP_REPORT_LINE:recordList:)];
}

@end

@implementation EXPDetailDataSource

-(id)init{
    
    self=[super init];
    if(self){
        //以后将改为由依赖注入
        EXPDetailModel * detailModel = [[EXPDetailModel alloc] init];
        self.model =detailModel;
        
    }
    return self;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        LMCellStypeItem *temp = [[LMCellStypeItem alloc]init];
        temp = [[_items objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        
        
        NSLog(@"%@",temp.primary_id);
        
        NSDictionary *deleteID = [NSDictionary dictionaryWithObject:temp.primary_id forKey:@"id"];
        NSArray * param = @[deleteID];
        
        [[_items objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [(EXPDetailModel *)self.model deleteCell:param];
        
        [self.DetailTvC reload];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
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
    
    
    NSArray * arr = [[NSUserDefaults standardUserDefaults] valueForKey:@"expense_classes"];
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
                
                * [[record objectForKey:@"expense_number"] integerValue];
            }
        }
        sumMoney = [NSString stringWithFormat:@"%.1f",sumMoneyInt];
        
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
                
          
                
                
                LMCellStypeItem * cellitem = [LMCellStypeItem itemWithText:self selector:@selector(openURLForItem:)];
                
                
                cellitem.expense_class_id = [record valueForKey:@"expense_class_id"];
                cellitem.amount = [[record valueForKey:@"expense_amount"] floatValue]
                * [[record valueForKey:@"expense_number"]floatValue]
                
                ;
                
                [[record valueForKey:@"expense_number"] integerValue];
                
          
                cellitem.primary_id =  [record valueForKey:@"id"];
                

                
                cellitem.status = [record valueForKey:@"local_status"];

                
                NSString * exp_expense_type_desc = [record valueForKey:@"expense_type_desc"];
                NSString *  expense_class_desc = [record  valueForKey:@"expense_class_desc"];
                cellitem.expense_type_desc =  [[expense_class_desc stringByAppendingString:@">"] stringByAppendingString:exp_expense_type_desc];
                
                cellitem.line_desc =[record valueForKey:@"description"];
                
                cellitem.userInfo = @"EXPDetailLineGuider";
               
                
                for(int i = 0;i<arr.count;i++){

                    NSNumber * classid =    [arr[i] valueForKey:@"expense_class_id"];
                    
                    if([classid integerValue] == [cellitem.expense_class_id integerValue]){
                        
                        NSString * imgaeName = [arr[i] valueForKey:@"image_url"];
                        cellitem.imageDisplay =imgaeName;
                        
                    }
                    
               
                    
                }
                
                
                
                
                [item addObject:cellitem];
                
                                          
            }
            
        }
        [items addObject:item];
       
        
    }
    
    self.sections = sections;
    self.items = items;

}


-(void)openURLForItem:(LMCellStypeItem *) item
{

    if ([item.userInfo isEqualToString:@"EXPDetailLineGuider"] ){

       EXPLineModelDetailViewController *detailViewController = [[EXPLineModelDetailViewController alloc]initWithNibName:nil bundle:nil];        
        
        if ([item.status compare:@"new"] != 0) {
            detailViewController.readOnlyFlag = YES;
        }
        
        
        detailViewController.insertFlag = NO;
        detailViewController.updateFlag = YES;
        detailViewController.keyId = item.primary_id;
        detailViewController.detailList = self.DetailTvC;

        [self.DetailTvC.navigationController pushViewController:detailViewController animated:YES];
        
    }
        

}

@end