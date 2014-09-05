//
//  MJCircleLayer.m
//  MJCircleView
//
//  Created by tenric on 13-6-29.
//  Copyright (c) 2013年 tenric. All rights reserved.
//

#import "MJCircleLayer.h"
#import "MJPasswordView.h"

@implementation MJCircleLayer

- (void)drawInContext:(CGContextRef)ctx
{
    CGRect circleFrame = self.bounds;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:circleFrame
                            cornerRadius:circleFrame.size.height / 2.0];
    
    CGContextSetFillColorWithColor(ctx, self.passwordView.circleFillColour.CGColor);
    CGContextAddPath(ctx, circlePath.CGPath);
    CGContextFillPath(ctx);
    

    if (self.highlighted)
    {
        CGContextSetFillColorWithColor(ctx, self.passwordView.circleFillColourHighlighted.CGColor);
        NSLog(@"%f,,,%f",self.bounds.origin.x,self.bounds.origin.y);
        
//        CGContextFillEllipseInRect(ctx, CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height));

        
       CGContextAddPath(ctx, circlePath.CGPath);
       CGContextFillPath(ctx);
        

        CGContextAddArc(ctx, circleFrame.origin.x+circleFrame.size.width/2, circleFrame.origin.y+circleFrame.size.height/2, 15, 0,2*M_PI , 0);
        CGContextClosePath(ctx);
        CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
        CGContextFillPath(ctx);
    }
}


@end
