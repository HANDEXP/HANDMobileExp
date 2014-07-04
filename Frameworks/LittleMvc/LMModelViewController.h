//
//  LMModelViewController.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-3.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMModelDelegate.h"
#import "LMModel.h"
@interface LMModelViewController : UIViewController<LMModelDelegate>{
    
    id<TTModel> _model;
}
- (void)setModel:(id<TTModel>)model ;

@end
