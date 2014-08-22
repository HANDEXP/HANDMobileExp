//
//  LMTableViewDataSource.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-5.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableViewDataSource.h"
#import "LMTableImageItemCellTableViewCell.h"
#import "LMCellStypeItem.h"
#import "LMCellStype.h"
#import "LMBasicFunctionItem.h"
#import "LMBasicFunctionItemCell.h"
#import "LMDetailListTableViewCell.h"
#import "LMCellStypeItem_1.h"
#import "LMDetailListTableViewCell_1.h"


@implementation LMTableViewDataSource


#pragma mark -
#pragma mark TTTableViewDataSource
///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object {
    if([object isKindOfClass:[LMTableItem class]]){
    
      if ([object isKindOfClass:[LMTableImageItem class]]) {
            return [LMTableImageItemCellTableViewCell class];
            
      }else if([object isKindOfClass:[LMCellStypeItem class]]){
         // NSLog(@"%@",[LMCellStypeItem class]);
          return [LMDetailListTableViewCell class];
      }else if([object isKindOfClass:[LMBasicFunctionItem class]]){
          
          return [LMBasicFunctionItemCell class];
      }else if([object isKindOfClass:[LMCellStypeItem_1 class]])
          return [LMDetailListTableViewCell_1 class];
    
    }
    
    
    // This will display an empty white table cell - probably not what you want, but it
    // is better than crashing, which is what happens if you return nil here
    return  [UITableViewCell class];
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)tableView:(UITableView*)tableView objectForRowAtIndexPath:(NSIndexPath*)indexPath {
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView*)tableView cell:(UITableViewCell*)cell
willAppearAtIndexPath:(NSIndexPath*)indexPath {
    
}

///在加载完必后，调用table 的 didfinish触发的，子类需要重写
- (void)tableViewDidLoadModel:(UITableView*)tableView {
}



#pragma mark -
#pragma mark UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id object = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = [self tableView:tableView cellClassForObject:object];
    const char * className = class_getName(cellClass);
    NSString* identifier = [[NSString alloc] initWithBytesNoCopy:(char*)className
                                                          length:strlen(className)
                                                        encoding:NSASCIIStringEncoding freeWhenDone:NO];
    
    UITableViewCell* cell =
    (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:identifier] ;
    }
      if ([cell isKindOfClass:[LMTableImageItemCellTableViewCell class]]) {
          [(LMTableImageItemCellTableViewCell*)cell setObject:object];
      }else if([cell isKindOfClass:[LMDetailListTableViewCell class]]){
          [(LMDetailListTableViewCell*)cell setObject:object];
      }else if([cell isKindOfClass:[LMBasicFunctionItemCell class]]){
          [(LMBasicFunctionItemCell *)cell setObject:object];
      }else if([cell isKindOfClass:[LMDetailListTableViewCell_1 class]]){
          [(LMDetailListTableViewCell_1*)cell setObject:object];
      }
    [self tableView:tableView cell:cell willAppearAtIndexPath:indexPath];
    
    return  cell;
    
}



@end
