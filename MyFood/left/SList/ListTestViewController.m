//
//  ListTestViewController.m
//  MyFood
//
//  Created by qunlee on 16/8/29.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "ListTestViewController.h"
#import "TestListCell.h"
#import "EQXColor.h"
#import "PureLayout/PureLayout.h"

@interface ListTestViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) UITableView *listTableView;
@end

@implementation ListTestViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    [self addTalbeView];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = [self viewControllerForRowAtIndexPath:indexPath];
    viewController.title = [self titleForRowAtIndexPath:indexPath];
    [self testShowWithViewController:viewController];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}
- (void)testShowWithViewController:(UIViewController *)viewController{
#if 0
    if ([viewController isKindOfClass:[ListTestViewController class]]) {
        UIViewController *vc = (ListTestViewController *)viewController;
        __weak UIViewController *weakSelf = self;
        vc.doDuff = ^(NSString *string){
            if (weakSelf) {
                NSLog(@"%@", string);
                if (weakSelf) {
                    self.testObject = string;
                    [weakSelf.navigationController.navigationBar.topItem setTitle:string];
                }
            }
        };
    }
#endif
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}
//UIProgressView在cell中改变TintColor时，需要采用Appearance方式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestListCell class])
                                                              forIndexPath:indexPath];
    cell.listTitleLabel.text = [self.items[indexPath.row] firstObject];
    [[UIProgressView appearance] setProgressTintColor:[EQXColor colorWithHexString:@"#50b440"]];
    cell.proview.progress = 0.01;
    return cell;
}
- (void)addTalbeView{
    self.items = @[@[@"字体", [UIViewController class]],
                   @[@"场景列表", [UIViewController class]],
                   @[@"GCD", [UIViewController class]],
                   @[@"Sqlite", [UIViewController class]],
                   @[@"Photo", [UIViewController class]],
                   @[@"Memory manageMent", [UIViewController class]],
                   @[@"tabview_test", [UIViewController class]]
                   ];
    self.listTableView = [UITableView newAutoLayoutView];
    [self.listTableView registerClass:[TestListCell class]
           forCellReuseIdentifier:NSStringFromClass([TestListCell class])];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.listTableView.rowHeight = 50.f;
    [self.view addSubview:self.listTableView];
    [self.listTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
}
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.items[indexPath.row] firstObject];
}
- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.items[indexPath.row] lastObject] new];
}

@end
