//
//  EXPHomeTable.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-7.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPHomeTable.h"

static NSString *tableViewCellIdentifier = @"MyCells";

@implementation EXPHomeTable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        
        tableView.backgroundColor = [UIColor colorWithRed:0.876 green:0.874 blue:0.760 alpha:0.310];
        
        tableView.contentSize = CGSizeMake(tableView.frame.size.width, tableView.frame.size.height);
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellIdentifier];
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        
        tableView.scrollEnabled = NO;
        [self addSubview:tableView];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    cell = [tableView
            dequeueReusableCellWithIdentifier:tableViewCellIdentifier
            forIndexPath:indexPath];
    cell.textLabel.text = @"待定";
    
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:1.000 green:0.978 blue:0.904 alpha:1.000];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textAlignment = NSTextAlignmentRight;

    if (indexPath.section ==0 && indexPath.row == 0) {
        cell.textLabel.text = @"记一笔";
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:25.0f];
        [cell.imageView setImage:[UIImage imageNamed:@"note"]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.bounds.size.height/3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"记一笔");
}



@end
