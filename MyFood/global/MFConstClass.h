//
//  MFConstClass.h
//  MyFood
//
//  Created by qunlee on 16/8/25.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability/Reachability.h"

@interface MFConstClass : NSObject
//@property (nonatomic, weak) NSMutableArray *dataArray;
///随机色
+ (UIColor *)getRandomColor;
///反射机制 - NSString
+ (NSArray *)getPropertiesOfObject:(id)object;
///反射机制 - variable
+ (NSArray *)getVariableNameOfObject:(id)object;
///解析列表
+ (NSMutableArray *)parseListWithItemClassName:(NSString *)className withList:(NSArray *)array;
/** 监听网络状态 */
- (NetworkStatus)reachabilityChanged;
@end
