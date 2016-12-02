//
//  PartAlphaView.m
//  MyFood
//
//  Created by qunlee on 16/12/1.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "PartAlphaView.h"

@implementation PartAlphaView


- (void)drawRect:(CGRect)rect {
    //部分强调显示
    CGRect frame = self.bounds;
    [[[UIColor blackColor]colorWithAlphaComponent:0.7] set];
    UIRectFill(frame);
    [[UIColor clearColor] set];
    UIRectFill(CGRectMake(50, 250, 100, 100));
    return;
    //绘制线
    CGRect rBounds = self.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[[UIColor blackColor] colorWithAlphaComponent:0.7] CGColor]);
    CGContextFillRect(context, rBounds);
    
    CGContextSetStrokeColorWithColor(context, [[[UIColor whiteColor] colorWithAlphaComponent:0.7] CGColor]);
    CGContextSetLineWidth(context, 100);
    CGContextStrokeRect(context, self.maskRect);
}


@end
