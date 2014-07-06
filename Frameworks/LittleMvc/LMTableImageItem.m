//
//  LMTableImageItem.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-5.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableImageItem.h"

@implementation LMTableImageItem

@synthesize imageURL      = _imageURL;
@synthesize text      = _text;



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class public

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL delegate:(id)delegate selector :(SEL)selector{
    LMTableImageItem* item = [[self alloc] init];
    item.text = text;
    item.imageURL = imageURL;
    item.selector =selector;
    item.delegate = delegate;
    return item;
}
@end
