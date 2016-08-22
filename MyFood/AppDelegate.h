//
//  AppDelegate.h
//  MyFood
//
//  Created by qunlee on 16/6/17.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WIDTH_OF_SCREEN CGRectGetWidth([UIScreen mainScreen].bounds)
#define HEIGHT_OF_SCREEN  CGRectGetHeight([UIScreen mainScreen].bounds)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

