//
//  ViewController.h
//  MyFood
//
//  Created by qunlee on 16/6/17.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"
#import "EQXTabbarController.h"

@interface ViewController : UIViewController<RNFrostedSidebarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *MainPageTableView;

@end

