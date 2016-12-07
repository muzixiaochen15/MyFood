//
//  BokeListViewController.m
//  MyFood
//
//  Created by qunlee on 16/12/7.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "BokeListViewController.h"
#import "EQXColor.h"
#import "MenuTableViewCell.h"
#import "BokeDetailViewController.h"

@interface BokeListViewController (){
    NSArray *items;
}
@end

@implementation BokeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [EQXColor colorWithHexString:@"#f8f8f8"];
    
    items = @[@[@"https://hit-alibaba.github.io/interview/", [BokeDetailViewController class]],
              @[@"https://hjgitbook.gitbooks.io/ios/content/", [BokeDetailViewController class]],
              @[@"网页3", [BokeDetailViewController class]]
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
    BokeDetailViewController *viewController = [[items[indexPath.row]lastObject] new];
    viewController.hidesBottomBarWhenPushed = YES;
    viewController.urlString = [items[indexPath.row] firstObject];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MenuTableViewCell class])
                                                              forIndexPath:indexPath];
    cell.textLabel.text = [items[indexPath.row] firstObject];
    return cell;
}

@end
