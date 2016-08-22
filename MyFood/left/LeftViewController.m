//
//  LeftViewController.m
//  MyFood
//
//  Created by qunlee on 16/8/8.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "LeftViewController.h"
#import "MenuTableViewCell.h"
#import "FontStoreViewController.h"
#import "SceneListViewController.h"
#import "UIColor+CustomColors.h"
#import "MultiThreadViewController.h"
#import "SqliteViewController.h"
#import "photo/PhotoCollectionController.h"

@interface LeftViewController()
@property(nonatomic) NSArray *items;
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)configureTableView;
@end

@implementation LeftViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"创作";
    [self configureTableView];
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = [self viewControllerForRowAtIndexPath:indexPath];
    viewController.title = [self titleForRowAtIndexPath:indexPath];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController
                                         animated:YES];
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                              forIndexPath:indexPath];
    cell.textLabel.text = [self.items[indexPath.row] firstObject];
    return cell;
}

#pragma mark - Private Instance methods
- (void)configureTableView{
    self.items = @[@[@"字体", [FontStoreViewController class]],
                   @[@"场景列表", [SceneListViewController class]],
                   @[@"GCD", [MultiThreadViewController class]],
                   @[@"Sqlite", [SqliteViewController class]],
                   @[@"Photo", [PhotoCollectionController class]]
                   ];
    [self.tableView registerClass:[MenuTableViewCell class]
           forCellReuseIdentifier:kCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight = 50.f;
}

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.items[indexPath.row] firstObject];
}

- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.items[indexPath.row] lastObject] new];
}

@end
