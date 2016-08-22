//
//  ViewController.m
//  MyFood
//
//  Created by qunlee on 16/6/17.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "ViewController.h"
#import "CommUtls.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _MainPageTableView.delegate = self;
    _MainPageTableView.dataSource = self;
    [_MainPageTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
//    [_MainPageTableView setTableHeaderView:[self createTableViewHeadView]];
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
}
- (IBAction)onBurger:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"gear"],
                        [UIImage imageNamed:@"globe"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"star"],
                        [UIImage imageNamed:@"gear"],
                        [UIImage imageNamed:@"globe"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"star"],
                        [UIImage imageNamed:@"gear"],
                        [UIImage imageNamed:@"globe"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"star"],
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    callout.delegate = self;
    [callout show];
}
- (UIView *)createTableViewHeadView{
    NSArray *imageArray = @[@"sceneCreateList0", @"sceneCreateList1", @"sceneCreateList2", @"sceneCreateList3", @"sceneCreateList3", @"sceneCreateList2", @"sceneCreateList1", @"sceneCreateList0"];
    NSArray *titleArray = @[@"收藏", @"照片", @"宝箱", @"新建", @"新建", @"宝箱", @"照片", @"收藏"];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.frame), 172.0f)];
    
    for (int st = 0; st < [imageArray count]; st++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(st%4 * CGRectGetWidth(self.view.frame)/4.0f, st/4 * 80.0f, CGRectGetWidth(self.view.frame)/4.0f, 80.0f);
        button.backgroundColor = [UIColor cyanColor];
        [button setImage:[UIImage imageNamed:imageArray[st]] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,button.titleLabel.bounds.size.width);
        [button setTitle:titleArray[st] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(71, -button.titleLabel.bounds.size.width-50, 0, 0);
        [button setTitleColor:[CommUtls colorWithHexString:@"#444444"] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [headView addSubview:button];
    }
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(headView.frame) - 10.0f, CGRectGetWidth(self.view.frame), 10.0f)];
    bottomView.backgroundColor = [CommUtls colorWithHexString:@"#f6f6f6"];
    [headView addSubview:bottomView];
    
    UIView *cuttingLine1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.frame), 0.5f)];
    cuttingLine1.backgroundColor = [CommUtls colorWithHexString:@"#e0e0e0"];
    [bottomView addSubview:cuttingLine1];
    UIView *cuttingLine2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.frame), 9.5f)];
    cuttingLine2.backgroundColor = [CommUtls colorWithHexString:@"#e0e0e0"];
    [bottomView addSubview:cuttingLine2];
    
    return headView;
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %lu",(unsigned long)index);
    if (index == 3) {
        [sidebar dismissAnimated:YES completion:nil];
    }
}
- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}


@end
