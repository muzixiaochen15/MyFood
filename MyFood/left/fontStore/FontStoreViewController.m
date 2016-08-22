//
//  FontStoreViewController.m
//  MyFood
//
//  Created by qunlee on 16/8/8.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "FontStoreViewController.h"
#import "EQXColor.h"
#import "FontStoreCell.h"
#import "PureLayout.h"
#import "AppDelegate.h"

@implementation FontStoreViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f6f6f6"]];
    [self createNavBar];
    [self configureTableView];
    [self createRequest];
}
#pragma mark - personal inferface
- (void)createNavBar{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
}
- (void)configureTableView{
    columnTab = [FontStoreColumnTableView newAutoLayoutView];
    columnTab.delegate = self;
    [self.view addSubview:columnTab];
    [columnTab autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
}
- (void)createRequest{
    req = [[FontStoreRequest alloc]init];
    req.delegate = self;
    [req getFontStoreList];
}
#pragma mark - FontStoreListDelegate
- (void)refreshFontStoreListWithDict:(NSDictionary *)dict{
    [columnTab testRefreshListView];
}
#pragma mark - footRefresh
- (void)footRefreshToReloadMore{
    [req getFontStoreList];
}
@end
