//
//  EQXColor.h
//  MyFood
//
//  Created by qunlee on 16/8/5.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EQXColor : NSObject
//转换颜色色值
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
//转换颜色色值，有透明度
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert withAlpha:(CGFloat)alpha;
@end
