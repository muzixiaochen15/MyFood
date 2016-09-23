//
//  FontStoreTableView.m
//  MyFood
//
//  Created by qunlee on 16/8/9.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "FontStoreTableView.h"
#import "PureLayout/PureLayout.h"
#import "EQXColor.h"
#import "AppDelegate.h"
#import "FontStoreCell.h"

@implementation FontStoreTableView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createNoDataView];
        [self createListView];
        [self createFootRefreshView];
    }
    return self;
}
#pragma mark - UITableViewDelegate、UITableViewDataSource
//分割线左右无间隔
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_delegate) {
        @throw [NSException exceptionWithName:@"cell高度生成失败" reason:@"delegate = nil" userInfo:nil];
    }
    return [_delegate cellHeightWithIndex:indexPath.row];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_delegate) {
        @throw [NSException exceptionWithName:@"cell生成失败" reason:@"delegate = nil" userInfo:nil];
    }
    return [_delegate cellForRowWithIndex:indexPath withTableView:tableView];
}

#pragma mark - Table view delegate
static CGFloat const headerHeight = 33.0f;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerHeight;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section < 2) {
        return 1;
    }
    return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), headerHeight)];
    view.backgroundColor = [EQXColor colorWithHexString:@"#f8f8f8"];
    UIView *verticalView = [[UIView alloc]initWithFrame:CGRectMake(15.0f, 8.0f, 5.0f, 17.0f)];
    verticalView.backgroundColor = [EQXColor colorWithHexString:@"#56c6ff"];
    [view addSubview:verticalView];
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(25.0f, 0.0f, CGRectGetWidth(self.frame) - 40.0f, headerHeight)];
    leftLabel.textColor = [EQXColor colorWithHexString:@"#303030"];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    switch (section) {
        case 0:
        {
            leftLabel.font = [UIFont fontWithName:@"PingFangSC-Ultralight" size:17.0f];
            leftLabel.text = @"猜你喜欢";
        }
            break;
        case 1:
        {
            leftLabel.font = [UIFont fontWithName:@"PingFangSC-Ultralight" size:17.0f];
            leftLabel.text = @"本周推荐";
        }
            break;
        default:
        {
            leftLabel.font = [UIFont fontWithName:@"PingFangSC-Ultralight" size:17.0f];
            leftLabel.text = @"字体分类";
        }
            break;
    }
    [view addSubview:leftLabel];
    return view;
}
#pragma mark - refreshView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _listTableview) {
        [footRefreshView egoRefreshScrollViewDidScroll:scrollView];
    }
}
- (void)egoRefreshScrollViewDidScroll{
    [footRefreshView egoRefreshScrollViewDidScroll:_listTableview];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y < 0||isNotMoreData) {
        return;
    }
    [footRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos {
    if (aRefreshPos == EGORefreshFooter) {
        [_delegate footRefreshToReloadMore];
    }
}
#pragma mark - finish
- (void)tableViewFinishLoading{
    [footRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_listTableview];
}
- (void)reloadListDataWithHasMoreData:(BOOL)hasMoreData{
    isNotMoreData = !hasMoreData;
    [_listTableview reloadData];
//    if (hasMoreData) {
//        footRefreshView.hidden = NO;
//    }else{
//        footRefreshView.hidden = YES;
//    }
//    if ([_dataArray count] == 0) {
//        noDataView.hidden = NO;
//    }else{
//        noDataView.hidden = YES;
//    }
    [self setRefreshViewFrameWithTableView:_listTableview];
}
#pragma mark - custom view
- (void)createNoDataView{
    noDataView = [UIView newAutoLayoutView];
    noDataView.backgroundColor = [UIColor clearColor];
    noDataView.hidden = YES;
    [self addSubview:noDataView];
    [noDataView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    //提示图片
    UIImage *image = [UIImage imageNamed:@"cryingFace"];
    UIButton *noDataRefreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    noDataRefreshBtn.backgroundColor = [UIColor clearColor];
    noDataRefreshBtn.userInteractionEnabled = NO;
    noDataRefreshBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [noDataRefreshBtn setBackgroundImage:image forState:UIControlStateNormal];
    [noDataView addSubview:noDataRefreshBtn];
    [noDataRefreshBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:102.0f];
    [noDataRefreshBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [noDataRefreshBtn autoSetDimensionsToSize:image.size];
    //提示文字
    UILabel *noDataLabel = [UILabel newAutoLayoutView];
    noDataLabel.text = @"您还没有购买字体呢";
    noDataLabel.textColor = [EQXColor colorWithHexString:@"#a3afb7"];
    noDataLabel.textAlignment = NSTextAlignmentCenter;
    noDataLabel.numberOfLines = 0;
    noDataLabel.font = [UIFont systemFontOfSize:15.0f];
    [noDataView addSubview:noDataLabel];
    [noDataLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:noDataRefreshBtn withOffset:15.0f];
    [noDataLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [noDataLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [noDataLabel autoSetDimension:ALDimensionHeight toSize:45.0f];
}
- (void)createListView{
    _listTableview = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, WIDTH_OF_SCREEN, CGRectGetHeight(self.frame)) style:UITableViewStylePlain];
    _listTableview.translatesAutoresizingMaskIntoConstraints = NO;
    _listTableview.backgroundColor = [UIColor clearColor];
    _listTableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, WIDTH_OF_SCREEN, 12.0f)];
    _listTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [_listTableview setSeparatorInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.5f, 0.0f)];
    [_listTableview setSeparatorColor:[EQXColor colorWithHexString:@"#e0e0e0"]];
    _listTableview.delegate = self;
    _listTableview.dataSource = self;
    _listTableview.hidden = NO;
    _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listTableview];
    [_listTableview autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f) excludingEdge:ALEdgeRight];
    [_listTableview autoSetDimension:ALDimensionWidth toSize:WIDTH_OF_SCREEN];
    [_listTableview autoConstrainAttribute:ALAttributeHeight toAttribute:ALAttributeHeight ofView:self];
    [_listTableview registerNib:[UINib nibWithNibName:@"FontStoreCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}
- (void)createFootRefreshView{
    footRefreshView = [[EGORefreshTableFooterView alloc]initWithFrame:CGRectZero];
    footRefreshView.delegate = self;
    footRefreshView.backgroundColor = [UIColor clearColor];
    [_listTableview addSubview:footRefreshView];
    [self setRefreshViewFrameWithTableView:_listTableview];
}
//刷新位置
- (void)setRefreshViewFrameWithTableView:(UITableView *)tableview {
    if (!tableview) {
        return;
    }
    //如果contentsize的高度比表的高度小，那么就需要把刷新视图放在表的bounds的下面
    CGFloat height = MAX(CGRectGetHeight(self.frame), tableview.contentSize.height);
    footRefreshView.frame = CGRectMake(0.0f, height, WIDTH_OF_SCREEN, 44.0f);
}
@end
