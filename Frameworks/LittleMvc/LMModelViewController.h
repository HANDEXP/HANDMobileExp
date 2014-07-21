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
#import "RESideMenu.h"
@interface LMModelViewController : UIViewController<LMModelDelegate>{
      id<TTModel> _model;
    
 
}
@property (nonatomic, retain) id<TTModel> model;



/**
 * Reloads data from the model.
 */
- (void)reload;

- (void)didLoadModel:(BOOL)firstTime;
@end
