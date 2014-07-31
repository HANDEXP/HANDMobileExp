//
//  EXPFunctionListDatasource.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-4.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPFunctionListDatasource.h"
#import "EXPHomeViewController.h"
#import "LMBasicFunctionItem.h"
#import "EXPDataSettingViewController.h"

@implementation EXPFunctionListDatasource

-(id)init{
    
    self=[super init];
    if(self){
        //以后将改为由依赖注入
        EXPFunctionListModel * fmodel = [[EXPFunctionListModel alloc] init];
        self.model =fmodel;
    }
    return self;
}


#pragma -mark TTTableViewDataSource delegate
-(void)tableViewDidLoadModel:(UITableView *)tableView
{

      AFNetRequestModel * model = self.model;
     NSArray *sectionList = [[model.Json valueForKeyPath:@"body"] valueForKeyPath:@"list"];
    
    NSMutableArray* items = [NSMutableArray array];

   
    for (NSDictionary * sectiondata in sectionList) {
       NSArray * result =  [sectiondata valueForKey:@"items"];
      
        for (NSDictionary * item in result) {
            NSString * text = [item valueForKey:@"title"];
            NSString * imageURL = [item valueForKey:@"image_url"];
            NSString * URL = [[item valueForKey:@"url"] stringByReplacingSpaceHodlerWithDictionary:@{@"base_url":[[NSUserDefaults standardUserDefaults] objectForKey:@"base_url_preference"]}];
            NSLog(@"text is %@",text);
            LMTableImageItem * imageItem =[LMTableImageItem itemWithText:text imageURL:imageURL delegate:self
                                                                selector:@selector(openURLForItem:)];
            imageItem.userInfo = URL;
            [items addObject:imageItem];
        }
        
    }
    self.items = items;
    [self addBasicItems];
    


   
}

-(void)addBasicItems{
//    LMTableImageItem * imageItem =[LMTableImageItem itemWithText:@"首页" imageURL:@"Home"];
//    imageItem.userInfo = @"HomeGuider";
//    [self.items insertObject:imageItem atIndex:0];
    LMBasicFunctionItem * imageItem = [LMBasicFunctionItem initWithTitle:@"主页" imageUrl:@"home" delegate:self selector:@selector(openURLForItem:)];
    

    imageItem.userInfo = @"HomeGuider";
    [self.items insertObject:imageItem atIndex:0];
    
    
     imageItem = [LMBasicFunctionItem initWithTitle:@"设置" imageUrl:@"settings" delegate:self selector:@selector(openURLForItem:)];
    imageItem.userInfo = @"SyncGuider";
    
    

    
    
    [self.items addObject:imageItem];
    
}

-(void)openURLForItem:(LMTableItem *) item
{
    
    if([item.userInfo hasPrefix:@"http://"]){
        LMTableImageItem * _item = item;
        [self.ViewController.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[EXPWebViewController alloc] initWithUrl:_item.userInfo title:_item.text]]
                                                                    animated:YES];
        [self.ViewController.sideMenuViewController hideMenuViewController];
        
    }else if ([item.userInfo isEqualToString:@"HomeGuider"] ){
        [self.ViewController.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[EXPHomeViewController alloc] initWithNibName:nil bundle:nil]]
                                                                    animated:YES];
        [self.ViewController.sideMenuViewController hideMenuViewController];
        
    }else if ([item.userInfo isEqualToString:@"SyncGuider"]){
        UIStoryboard *StoryBoard = [UIStoryboard storyboardWithName:@"SettingStoryboard" bundle:nil];
        EXPDataSettingViewController * dataSetting = [StoryBoard instantiateViewControllerWithIdentifier:@"EXPDataSettingViewController"];
        [self.ViewController.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:dataSetting]
                                                                    animated:YES];
        [self.ViewController.sideMenuViewController hideMenuViewController];
        
//        EXPFunctionListModel * arModel =  (AFNetRequestModel *)self.model;
//        arModel.tag = @"SyncGuider";
//        [arModel loadExpenseClass];
        
    }
}

@end
