//
//  LMModel.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-3.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArrayAdditions.h"
@protocol TTModel <NSObject>


/**
 * An array of objects that conform to the TTModelDelegate protocol.
 */
- (NSMutableArray*)delegates;
/**
 * Indicates that the data wheather load by set model.
 *
 * Default implementation returns YES.
 */

-(BOOL)autoLoaded;
/**
 * Indicates that the data has been loaded.
 *
 * Default implementation returns YES.
 */
- (BOOL)isLoaded;

/**
 * Indicates that the data is in the process of loading.
 *
 * Default implementation returns NO.
 */
- (BOOL)isLoading;

/**
 * Indicates that the data is in the process of loading additional data.
 *
 * Default implementation returns NO.
 */
- (BOOL)isLoadingMore;

/**
 * Indicates that the model is of date and should be reloaded as soon as possible.
 *
 * Default implementation returns NO.
 */
-(BOOL)isOutdated;

/**
 * Loads the model.
 *
 * Default implementation does nothing.
 */

- (void)load:(int)cachePolicy more:(BOOL)more;


@end

@interface LMModel : NSObject <TTModel>{
    NSMutableArray* _delegates;
    
}

@property(nonatomic,strong) NSString * tag;
@property(nonatomic,strong) id   info;

- (NSMutableArray*)delegates;
/**
 * Notifies delegates that the model started to load.
 */
- (void)didStartLoad;

/**
 * Notifies delegates that the model finished loading
 */
- (void)didFinishLoad;

/**
 * Notifies delegates that the model failed to load.
 */
- (void)didFailLoadWithError:(NSError*)error;

/**
 * Notifies delegates that the model canceled its load.
 */
- (void)didCancelLoad;

@end
