//
//  RightViewController.h
//  MyFood
//
//  Created by qunlee on 16/11/10.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BokeDetailViewController : UIViewController<WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) NSString *urlString;
@end
