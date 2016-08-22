//
//  FontStoreTableView.h
//  MyFood
//
//  Created by qunlee on 16/8/9.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableFooterView.h"

@protocol FontStoreTableViewDelegate <NSObject>

- (CGFloat)cellHeightWithIndex:(NSUInteger)row;
- (UITableViewCell *)cellForRowWithIndex:(NSIndexPath *)indexPath withTableView:(UITableView *)tableview;
/** 上拉刷新 */
- (void)footRefreshToReloadMore;
@end

static NSString * const kCellIdentifier = @"CellIdentifier";

@interface FontStoreTableView : UIView <UITableViewDelegate, UITableViewDataSource, EGORefreshTableDelegate>{
    UIView *noDataView;
    EGORefreshTableFooterView *footRefreshView;
    /** 没有更多数据 */
    BOOL isNotMoreData;
}
@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSUInteger currentColumn;
@property (nonatomic, assign) id<FontStoreTableViewDelegate> delegate;
- (void)egoRefreshScrollViewDidScroll;
- (void)reloadListDataWithHasMoreData:(BOOL)hasMoreData;
- (void)tableViewFinishLoading;
@end
