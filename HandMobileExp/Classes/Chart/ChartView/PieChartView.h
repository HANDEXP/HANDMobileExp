
#import <UIKit/UIKit.h>
#import "RotatedView.h"
@class PieChartView;
@protocol PieChartDelegate <NSObject>
@optional
- (void)selectedFinish:(PieChartView *)pieChartView index:(NSInteger)index percent:(float)per;
- (void)onCenterClick:(PieChartView *)PieChartView;
@end

@interface PieChartView : UIView <RotatedViewDelegate>
@property(nonatomic, assign) id<PieChartDelegate> delegate;
- (id)initWithFrame:(CGRect)frame withValue:(NSMutableArray *)valueArr withColor:(NSMutableArray *)colorArr;
- (void)reloadChart;

- (void) reloadChartWithValueArr: (NSMutableArray *)valueArr ColorArr: (NSMutableArray *)colorArr;
- (void)setAmountText:(NSString *)text;
- (void)setTitleText:(NSString *)text;
@end
