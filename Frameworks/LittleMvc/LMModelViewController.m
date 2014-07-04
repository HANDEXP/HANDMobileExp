//
//  LMModelViewController.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-3.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMModelViewController.h"

@interface LMModelViewController ()

@end

@implementation LMModelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init {
	self = [self initWithNibName:nil bundle:nil];
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)refresh{
    NSLog(@"in refresh");
    [self.model load:0 more:false];
}

- (id<TTModel>)model {
    if (!_model) {
        
    }
    return _model;
}

- (void)setModel:(id<TTModel>)model {
    if (_model != model) {
        _model = model;
        [_model.delegates removeObject:self];
        [_model.delegates addObject:self];
        if([_model autoLoaded]){
            
            [self refresh];
        }
    }
    
}

@end
