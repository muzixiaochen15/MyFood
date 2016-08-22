//
//  FontStoreColumnTableView.m
//  MyFood
//
//  Created by qunlee on 16/8/9.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "FontStoreColumnTableView.h"
#import "PureLayout/PureLayout.h"
#import "AppDelegate.h"
#import "EQXColor.h"
#import "FontStoreCell.h"
#import "FontPriceTipView.h"

@implementation FontStoreColumnTableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createTableView];
        [self createTopView];
    }
    return self;
}
#pragma mark - UIScrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == scr) {
        sliderConstraint.constant = scrollView.contentOffset.x/2.0f;
    }
    if (scrollView == storeListTableView.listTableview) {
        [storeListTableView egoRefreshScrollViewDidScroll];
    }else if (scrollView == mineListTableView.listTableview){
        [mineListTableView egoRefreshScrollViewDidScroll];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == scr) {
        sliderConstraint.constant = scrollView.contentOffset.x/2.0f;
        if (sliderConstraint.constant >= WIDTH_OF_SCREEN/2.0f) {
            [self mineBtnClicked:mineBtn];
        }else{
            [self storeBtnClicked:storeBtn];
        }
    }
}
#pragma mark - FontStoreTableViewDelegate
static CGFloat const rowHeight = 130.0f;
- (CGFloat)cellHeightWithIndex:(NSUInteger)row{
    return rowHeight;
}
- (UITableViewCell *)cellForRowWithIndex:(NSIndexPath *)indexPath withTableView:(UITableView *)tableview{
    FontStoreCell *cell = [tableview dequeueReusableCellWithIdentifier:kCellIdentifier
                                                              forIndexPath:indexPath];
    return cell;
}
- (void)footRefreshToReloadMore{
//    if ([AppDelegate getAppDelegate].newWorkStyle == NetWorkConditionNotReachable){
//        [[AppDelegate getAppDelegate] showFailedActivityView:@"noNetWork" interval:1.0];
//        [tableView performSelector:@selector(tableViewFinishLoading) withObject:nil afterDelay:0.1];
//        return;
//    }
//    if (currentType == IncomeAndExpensesTypeAll) {
//        [allRequest getXiuDianLogListWithType:currentType withPageNo:allRequest.currentPageNo];
//    }else if (currentType == IncomeAndExpensesTypeIncome){
//        [salesRequest getXiuDianLogListWithType:currentType withPageNo:salesRequest.currentPageNo];
//    }else if (currentType == IncomeAndExpensesTypeExpenses){
//        [payRequest getXiuDianLogListWithType:currentType withPageNo:payRequest.currentPageNo];
//    }
    if (_delegate) {
        [_delegate footRefreshToReloadMore];
    }
}
#pragma mark - request
- (void)refreshLoglistWithArray:(NSMutableArray *)array withCanRequestMoreData:(BOOL)isHasMoreData{
    //是否有更多数据
#if 0
    if (array) {
        [tableView reloadListDataWithHasMoreData:isHasMoreData];
    }else{
        [[AppDelegate getAppDelegate] showFailedActivityView:@"allMessage" interval:1.0];
    }
    [tableView performSelector:@selector(tableViewFinishLoading) withObject:nil afterDelay:0.1];
#endif
}
- (void)testRefreshListView{
    if (storeBtn.selected) {
        [storeListTableView reloadListDataWithHasMoreData:YES];
        [storeListTableView performSelector:@selector(tableViewFinishLoading) withObject:nil afterDelay:0.1];
    }else if (mineBtn.selected){
        [mineListTableView reloadListDataWithHasMoreData:YES];
        [mineListTableView performSelector:@selector(tableViewFinishLoading) withObject:nil afterDelay:0.1];
    }
//    if (array) {
//        [tableView reloadListDataWithHasMoreData:isHasMoreData];
//    }else{
//        [[AppDelegate getAppDelegate] showFailedActivityView:@"allMessage" interval:1.0];
//    }
}
#pragma mark - custom view
- (void)createTableView{
    scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, WIDTH_OF_SCREEN, CGRectGetHeight(self.frame) - 40.0f)];
    scr.translatesAutoresizingMaskIntoConstraints = NO;
    scr.backgroundColor = [UIColor clearColor];
    scr.pagingEnabled = YES;
    scr.delegate = self;
    scr.bounces = NO;
    scr.showsHorizontalScrollIndicator = NO;
    [self addSubview:scr];
    [scr autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f) excludingEdge:ALEdgeTop];
    
    storeListTableView = [FontStoreTableView newAutoLayoutView];
    storeListTableView.backgroundColor = [UIColor clearColor];
    storeListTableView.delegate = self;
    [scr addSubview:storeListTableView];
    [storeListTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f) excludingEdge:ALEdgeRight];
    [storeListTableView autoSetDimension:ALDimensionWidth toSize:WIDTH_OF_SCREEN];
    [storeListTableView autoConstrainAttribute:ALAttributeHeight toAttribute:ALAttributeHeight ofView:scr];
    
    mineListTableView = [FontStoreTableView newAutoLayoutView];
    mineListTableView.backgroundColor = [UIColor clearColor];
    mineListTableView.delegate = self;
    [scr addSubview:mineListTableView];
    [mineListTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f) excludingEdge:ALEdgeLeft];
    [mineListTableView autoConstrainAttribute:ALAttributeHeight toAttribute:ALAttributeHeight ofView:scr];
    [mineListTableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:storeListTableView];
    [mineListTableView autoSetDimension:ALDimensionWidth toSize:WIDTH_OF_SCREEN];
}
- (void)createTopView{
    UIView *topView = [UIView newAutoLayoutView];
    topView.backgroundColor = [EQXColor colorWithHexString:@"#f8f8f8"];
    [self addSubview:topView];
    [topView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f) excludingEdge:ALEdgeBottom];
    [topView autoSetDimension:ALDimensionHeight toSize:40.0f];
    storeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    storeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    storeBtn.selected = YES;
    [storeBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    storeBtn.backgroundColor = [UIColor clearColor];
    [storeBtn addTarget:self action:@selector(storeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [storeBtn setTitleColor:[EQXColor colorWithHexString:@"#56c6ff"] forState:UIControlStateNormal];
    [storeBtn setTitle:@"商城" forState:UIControlStateNormal];
    [topView addSubview:storeBtn];
    [storeBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f) excludingEdge:ALEdgeRight];
    
    mineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mineBtn.translatesAutoresizingMaskIntoConstraints = NO;
    mineBtn.backgroundColor = [UIColor clearColor];
    mineBtn.selected = NO;
    [mineBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [mineBtn setTitle:@"我的" forState:UIControlStateNormal];
    [mineBtn addTarget:self action:@selector(mineBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [mineBtn setTitleColor:[EQXColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    [topView addSubview:mineBtn];
    [mineBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0) excludingEdge:ALEdgeLeft];
    [mineBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:storeBtn];
    [storeBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:mineBtn];
    
    UIView *topHorizontalLine = [UIView newAutoLayoutView];
    topHorizontalLine.backgroundColor = [EQXColor colorWithHexString:@"#e3e3e3"];
    [topView addSubview:topHorizontalLine];
    [topHorizontalLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.5f, 0.0f) excludingEdge:ALEdgeTop];
    [topHorizontalLine autoSetDimension:ALDimensionHeight toSize:0.5f];
    
    UIView *bottomHorizontalLine = [UIView newAutoLayoutView];
    bottomHorizontalLine.backgroundColor = [UIColor whiteColor];
    [topView addSubview:bottomHorizontalLine];
    [bottomHorizontalLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f) excludingEdge:ALEdgeTop];
    [bottomHorizontalLine autoSetDimension:ALDimensionHeight toSize:0.5f];
    
    UIView *leftVerticalLine = [UIView newAutoLayoutView];
    leftVerticalLine.backgroundColor = [EQXColor colorWithHexString:@"#e3e3e3"];
    [topView addSubview:leftVerticalLine];
    [leftVerticalLine autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0f];
    [leftVerticalLine autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10.0f];
    [leftVerticalLine autoSetDimension:ALDimensionWidth toSize:0.5f];
    [leftVerticalLine autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    UIView *rightVerticalLine = [UIView newAutoLayoutView];
    rightVerticalLine.backgroundColor = [UIColor whiteColor];
    [topView addSubview:rightVerticalLine];
    [rightVerticalLine autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0f];
    [rightVerticalLine autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10.0f];
    [rightVerticalLine autoSetDimension:ALDimensionWidth toSize:0.5f];
    [rightVerticalLine autoAlignAxis:ALAxisVertical toSameAxisOfView:topView withOffset:1.0f];
    
    [scr autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topView withOffset:0.0f];
    
    sliderView = [UIView newAutoLayoutView];
    sliderView.backgroundColor = [EQXColor colorWithHexString:@"#56c6ff"];
    [topView addSubview:sliderView];
    [sliderView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    sliderConstraint = [sliderView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [sliderView autoSetDimension:ALDimensionHeight toSize:2.0f];
    [sliderView autoSetDimension:ALDimensionWidth toSize:WIDTH_OF_SCREEN/2.0f];
}
- (void)storeBtnClicked:(UIButton *)button{
    if (button.selected) {
        return;
    }
    button.selected = YES;
    mineBtn.selected = NO;
    [button setTitleColor:[EQXColor colorWithHexString:@"#56c6ff"] forState:UIControlStateNormal];
    [mineBtn setTitleColor:[EQXColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        if (scr) {
            scr.contentOffset = CGPointMake(0.0f, 0.0f);
        }
    }];
}
- (void)mineBtnClicked:(UIButton *)button{
    if (button.selected) {
        return;
    }
    button.selected = YES;
    storeBtn.selected = NO;
    [button setTitleColor:[EQXColor colorWithHexString:@"#56c6ff"] forState:UIControlStateNormal];
    [storeBtn setTitleColor:[EQXColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        if (scr) {
            scr.contentOffset = CGPointMake(WIDTH_OF_SCREEN, 0.0f);
        }
    }];
}

@end
