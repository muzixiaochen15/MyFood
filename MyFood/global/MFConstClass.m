//
//  MFConstClass.m
//  MyFood
//
//  Created by qunlee on 16/8/25.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "MFConstClass.h"

@implementation MFConstClass

+ (UIColor *)getRandomColor{
    CGFloat red = arc4random_uniform(255)/255.0f;
    CGFloat green = arc4random_uniform(255)/255.0f;
    CGFloat blue = arc4random_uniform(255.0f)/255.0f;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    return color;
}

@end