//
//  EXPLineCellFirstSection.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-8.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPLineCellFirstSection.h"

@implementation EXPLineCellFirstSection




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"EXPCell" owner:self options:nil ];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}



@end
