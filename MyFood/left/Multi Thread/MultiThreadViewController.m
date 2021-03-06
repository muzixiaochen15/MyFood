//
//  MultiThreadViewController.m
//  MyFood
//
//  Created by qunlee on 16/8/18.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "MultiThreadViewController.h"
#import "PureLayout.h"
#import "EQXColor.h"
#import "NSThreadDemoViewController.h"
#import "NSOperationDemoController.h"
#import "GCDDemoViewController.h"
#import "MenuTableViewCell.h"

@interface MultiThreadViewController (){
    NSArray *items;
}
@end

@implementation MultiThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多线程";
    self.view.backgroundColor = [EQXColor colorWithHexString:@"#f8f8f8"];

    items = @[@[@"NSThread", [NSThreadDemoViewController class]],
              @[@"NSOperation", [NSOperationDemoController class]],
              @[@"GCD", [GCDDemoViewController class]]
              ];
    [self.tableView registerClass:[MenuTableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([MenuTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight = 50.0f;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return items.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *viewController = [[items[indexPath.row]lastObject] new];
    viewController.title = [items[indexPath.row] firstObject];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MenuTableViewCell class])
                                                              forIndexPath:indexPath];
    cell.textLabel.text = [items[indexPath.row] firstObject];
    return cell;
}
@end
