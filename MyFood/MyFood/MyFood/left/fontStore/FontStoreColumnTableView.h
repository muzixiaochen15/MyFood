//
//  FontStoreColumnTableView.h
//  MyFood
//
//  Created by qunlee on 16/8/9.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontStoreTableView.h"

@protocol FootRefreshDelegate <NSObject>
/** 上拉刷新 */
- (void)footRefreshToReloadMore;

@end
@interface FontStoreColumnTableView : UIView<UIScrollViewDelegate, FontStoreTableViewDelegate>{
    /** 滚动视图 */
    UIScrollView *scr;
    /** 字体商城 */
    FontStoreTableView *storeListTableView;
    /** 我的字体 */
    FontStoreTableView *mineListTableView;
    /** 滚动条 */
    UIView *sliderView;
    /** 滚动条偏移量 */
    NSLayoutConstraint *sliderConstraint;
    /** 商城 */
    UIButton *storeBtn;
    /** 我的 */
    UIButton *mineBtn;
}
/** 显示数据 */
@property (nonatomic, strong) NSArray *columnArray;
/** 上拉刷新 */
@property (nonatomic, strong) id<FootRefreshDelegate> delegate;
- (void)testRefreshListView;
@end
