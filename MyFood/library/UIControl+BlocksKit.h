//
//  UIControl+BlocksKit.h
//  MyFood
//
//  Created by qunlee on 16/8/31.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (BlocksKit)
- (void)bk_addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;
- (void)bk_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;

@end
