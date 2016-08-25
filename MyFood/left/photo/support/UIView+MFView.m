//
//  UIView+MFView.m
//  MyFood
//
//  Created by qunlee on 16/8/25.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "UIView+MFView.h"

@implementation UIView (MFView)
- (void)dealloc{
    NSLog(@"%@ release", NSStringFromClass([self class]));
}
- (void)setMfWidth:(CGFloat)mfWidth{
    
}
- (CGFloat)mfWidth{
    return 100.0f;
}
@end
