//
//  LMTableImageItem.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-5.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableImageItem.h"
#import "LMTableLinkedItem.h"


@interface LMTableImageItem : LMTableLinkedItem{
        NSString * _imageURL;
        NSString * _text;
}
@property(nonatomic,strong)NSString * imageURL;
@property(nonatomic,strong)NSString * text;


+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL delegate:(id)delegate selector :(SEL)selector;
@end
