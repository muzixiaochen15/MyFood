//
//  JuHeTableViewController.h
//  MyFood
//
//  Created by qunlee on 16/9/14.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuHeTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *listType;

// 监测范围的临界点,>0代表向上滑动多少距离,<0则是向下滑动多少距离
@property (nonatomic, assign) CGFloat theshold;
// 记录scrollView.contentInset.top
@property (nonatomic, assign) CGFloat marginTop;
//当前y偏移量
@property (nonatomic, assign) CGFloat currentOffsetY;
@end
