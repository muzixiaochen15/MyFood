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
#import "UIView+PS.h"
#import <PureLayout/PureLayout.h>
#import "BindPhoneTip.h"

#define WeakSelf(x)      __weak typeof (self) x = self
#define HalfFix(x) ((x)/2.0f)
#define Max_OffsetY  50.0f
#define STATUSBAR_HEIGHT     [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVBAR_HEIGHT        self.navigationController.navigationBar.frame.size.height
#define INVALID_VIEW_HEIGHT  (STATUSBAR_HEIGHT + NAVBAR_HEIGHT)
@interface BokeListViewController (){
    NSArray *items;
    CGFloat _lastPosition;
}
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIView *headBackView;
@property (nonatomic, strong) UIImageView * avatarView;
@property (nonatomic, strong) UILabel * messageLabel;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIButton *tipBellBtn;
@end

@implementation BokeListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [[UIApplication sharedApplication]setStatusBarHidden:YES];
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
//    [[UIApplication sharedApplication]setStatusBarHidden:NO];
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [EQXColor colorWithHexString:@"#f8f8f8"];
    [self addTableView];
    
    [self.tableView setTableHeaderView:self.headView];
    [_headView addSubview:self.headBackView];
    [self.tableView setTableFooterView:[[UIView alloc]init]];
    [self resetHeaderView];
    [self addButtons];
}
#pragma mark - views
- (void)resetHeaderView{
    self.headImageView.frame = self.headBackView.bounds;
    [self.headBackView addSubview:self.headImageView];
    
    [_headImageView addSubview:self.tipBellBtn];
    [_tipBellBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.0f];
    [_tipBellBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    [_tipBellBtn autoSetDimensionsToSize:CGSizeMake(40.0f, 40.0f)];
    
    self.avatarView.centerX = self.headBackView.centerX;
    self.avatarView.centerY = self.headBackView.centerY - HalfFix(70.0f);
    [self.headBackView addSubview:self.avatarView];
    
    self.messageLabel.text = @"你的名字";
    self.messageLabel.y = CGRectGetMaxY(self.avatarView.frame) + HalfFix(20.0f);
    self.messageLabel.size = CGSizeMake(Screen_Width - HalfFix(30.0f), 30.0f);
    self.messageLabel.centerX = self.headBackView.centerX;
    [self.headBackView addSubview:self.messageLabel];
}
- (void)addButtons{
    CGFloat width = Screen_Width/4.0f;
    for (int st = 0; st < 4; st++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        NSString *imageStr = [NSString stringWithFormat:@"sceneCreateList%d", st];
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        [_headView addSubview:button];
        [button autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_headBackView withOffset:30.0f];
        [button autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:width * st];
        [button autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [button autoSetDimension:ALDimensionWidth toSize:width];
    }
    UIView *topLine = [UIView newAutoLayoutView];
    topLine.backgroundColor = [EQXColor colorWithHexString:@"#e0e0e0"];
    [_headView addSubview:topLine];
    [topLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 70.0f, 0.0f) excludingEdge:ALEdgeTop];
    [topLine autoSetDimension:ALDimensionHeight toSize:0.5f];
    
    BindPhoneTip *tip = [BindPhoneTip newAutoLayoutView];
    tip.backgroundColor = [UIColor clearColor];
    [_headView addSubview:tip];
    [tip autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_headBackView];
    [tip autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [tip autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [tip autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:topLine];
    
    UIView *bottomLine = [UIView newAutoLayoutView];
    bottomLine.backgroundColor = [EQXColor colorWithHexString:@"#e0e0e0"];
    [_headView addSubview:bottomLine];
    [bottomLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f) excludingEdge:ALEdgeTop];
    [bottomLine autoSetDimension:ALDimensionHeight toSize:0.5f];
}
- (UIView *)headView{
    if (!_headView) {
        _headView = [UIView new];
        _headView.frame = CGRectMake(0.0f, 0.0f, Screen_Width, 300.0f);
        _headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}
- (UIButton *)tipBellBtn{
    if (!_tipBellBtn) {
        _tipBellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tipBellBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_tipBellBtn setImage:[UIImage imageNamed:@"normal_bell"] forState:UIControlStateNormal];
        [_tipBellBtn setImage:[UIImage imageNamed:@"bell"] forState:UIControlStateHighlighted];
    }
    return _tipBellBtn;
}
- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [UIImageView new];
        _headImageView.image = [UIImage imageNamed:@"bg"];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
        _headImageView.backgroundColor = [UIColor clearColor];
    }
    return _headImageView;
}
- (UIView *)headBackView{
    if (!_headBackView) {
        _headBackView = [UIView new];
        _headBackView.backgroundColor = [UIColor orangeColor];
        _headBackView.userInteractionEnabled = YES;
        _headBackView.frame = CGRectMake(0.0f, 0.0f, Screen_Width, 200.0f);
    }
    return _headBackView;
}
- (UIImageView*)avatarView
{
    if (!_avatarView) {
        _avatarView = [UIImageView new];
        _avatarView.image = [UIImage imageNamed:@"qzl"];
        _avatarView.contentMode = UIViewContentModeScaleToFill;
        _avatarView.frame = CGRectMake(0.0f, 0.0f, 80.0f, 80.0f);
        [_avatarView.layer setMasksToBounds:YES];
        [_avatarView.layer setCornerRadius:40.0f];
    }
    return _avatarView;
}
- (UILabel*)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textColor = [UIColor whiteColor];
    }
    return _messageLabel;
}

- (void)addTableView{
    items = @[@[@"https://hit-alibaba.github.io/interview/", [BokeDetailViewController class]],
              @[@"https://hjgitbook.gitbooks.io/ios/content/", [BokeDetailViewController class]],
              @[@"网页3", [BokeDetailViewController class]],
              @[@"网页4", [BokeDetailViewController class]],
              @[@"网页5", [BokeDetailViewController class]],
              @[@"网页6", [BokeDetailViewController class]],
              @[@"网页7", [BokeDetailViewController class]],
              @[@"网页8", [BokeDetailViewController class]],
              @[@"网页9", [BokeDetailViewController class]]
              ];
    [self.tableView registerClass:[MenuTableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([MenuTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight = 50.0f;
}
#pragma mark - scrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset_Y = scrollView.contentOffset.y;
    NSLog(@"offset.y = %f", offset_Y);
    //1.处理图片放大
    CGFloat imageH = self.headBackView.size.height;
    CGFloat imageW = Screen_Width;
    
    //下拉
    if (offset_Y < 0)
    {
        CGFloat totalOffset = imageH + ABS(offset_Y);
        CGFloat f = totalOffset / imageH;
        
        //如果想下拉固定头部视图不动，y和h 是要等比都设置。如不需要则y可为0
        self.headImageView.frame = CGRectMake(-(imageW * f - imageW) * 0.5, offset_Y, imageW * f, totalOffset);
    }
    else
    {
        self.headImageView.frame = self.headBackView.bounds;
    }
    return;
    //2.处理导航颜色渐变  3.底部工具栏动画
    
    if (offset_Y > Max_OffsetY)
    {
        CGFloat alpha = MIN(1, 1 - ((Max_OffsetY + INVALID_VIEW_HEIGHT - offset_Y) / INVALID_VIEW_HEIGHT));
        
//        [self.navigationController.navigationBar ps_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:alpha]];
        
        if (offset_Y - _lastPosition > 5)
        {
            //向上滚动
            _lastPosition = offset_Y;
            
            [self bottomForwardDownAnimation];
        }
        else if (_lastPosition - offset_Y > 5)
        {
            // 向下滚动
            _lastPosition = offset_Y;
            [self bottomForwardUpAnimation];
        }
        self.title = alpha > 0.8? @"权志龙":@"";
    }
    else
    {
//        [self.navigationController.navigationBar ps_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:0]];
        
        [self bottomForwardUpAnimation];
    }
    
    //滚动至顶部
    
//    if (offset_Y < 0) {
//        [self bottomForwardUpAnimation];
//        
//    }
    
    //滚动至底部
//    CGSize size = self.tableView.contentSize;
//    
//    float y = offset_Y + self.tableView.height;
//    float h = size.height;
//    float reload_distance = 10;
    
//    if (y > h - _bottomBar.height + reload_distance)
//    if (y > h - 0 + reload_distance) {
//        [self bottomForwardUpAnimation];
//    }
}
- (void)bottomForwardDownAnimation
{
    WeakSelf(weakSelf);
    [UIView animateWithDuration:0.2 animations: ^{
        if (weakSelf) {
            
        }
//        ws.bottomBar.transform = CGAffineTransformMakeTranslation(0, ws.bottomBar.height);
    } completion: ^(BOOL finished) {
    }];
}

- (void)bottomForwardUpAnimation
{
    WeakSelf(weakSelf);
    [UIView animateWithDuration:0.2 animations: ^{
        if (weakSelf) {
            
        }
//        ws.bottomBar.transform = CGAffineTransformIdentity;
    } completion: ^(BOOL finished) {
    }];
}
#pragma mark - tableviewdelegate,tableviewdatasource
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
