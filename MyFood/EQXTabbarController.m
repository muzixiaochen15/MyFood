//
//  EQXTabbarController.m
//  MyFood
//
//  Created by qunlee on 16/8/5.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "EQXTabbarController.h"
#import "EQXColor.h"
#import "ViewController.h"
#import "LeftViewController.h"
#import "MiddleCollectionViewController.h"
#import "RightViewController.h"

@implementation EQXTabbarController

- (void)viewDidLoad{
    [super viewDidLoad];
    LeftViewController *leftVC = [[LeftViewController alloc]init];
    [leftVC.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    UINavigationController *leftNav = [[UINavigationController alloc]initWithRootViewController:leftVC];
    //eqx_#212636
    [leftNav.navigationBar setBarTintColor:[EQXColor colorWithHexString:@"#e13e3f"]];
    leftNav.navigationBar.tintColor = [UIColor whiteColor];
    leftNav.navigationBar.topItem.title = @"创作";
    [leftNav.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [leftNav.navigationBar setTranslucent:NO];
    UITabBarItem *leftItem = [[UITabBarItem alloc]initWithTitle:@"创作" image:[UIImage imageNamed:@"tabbarCreateScene"] selectedImage:[[UIImage imageNamed:@"tabbarSelectCreateScene"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    leftNav.tabBarItem = leftItem;
    
    MiddleCollectionViewController *middleVC = [[MiddleCollectionViewController alloc]init];
    [middleVC.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    UINavigationController *middleNav = [[UINavigationController alloc]initWithRootViewController:middleVC];
    [middleNav.navigationBar setBarTintColor:[EQXColor colorWithHexString:@"#e13e3f"]];
    middleNav.navigationBar.tintColor = [UIColor whiteColor];
    middleNav.navigationBar.topItem.title = @"文本";
    [middleNav.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [middleNav.navigationBar setTranslucent:NO];
    UITabBarItem *midItem = [[UITabBarItem alloc]initWithTitle:@"文本" image:[UIImage imageNamed:@"tabbarNoSelectScene"] selectedImage:[[UIImage imageNamed:@"tabbarSelectScene"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    middleNav.tabBarItem = midItem;
    
    RightViewController *rightVC = [[RightViewController alloc]init];
    [rightVC.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    UINavigationController *rightNav = [[UINavigationController alloc]initWithRootViewController:rightVC];
    [rightNav.navigationBar setBarTintColor:[EQXColor colorWithHexString:@"#e13e3f"]];
    rightNav.navigationBar.tintColor = [UIColor whiteColor];
    rightNav.navigationBar.topItem.title = @"创作";
    [rightNav.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [rightNav.navigationBar setTranslucent:NO];
    UITabBarItem *rightItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"tabbarNoSelectClient"] selectedImage:[[UIImage imageNamed:@"tabbarSelectClient"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    rightNav.tabBarItem = rightItem;

    self.tabBar.opaque = YES;
    self.viewControllers = [NSArray arrayWithObjects:leftNav, middleNav, rightNav, nil];
    [self.tabBar setTintColor:[EQXColor colorWithHexString:@"#56c6ff"]];
}
- (BOOL)prefersStatusBarHidden{
    return NO;
}
@end
