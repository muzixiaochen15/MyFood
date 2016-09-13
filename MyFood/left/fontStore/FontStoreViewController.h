//
//  FontStoreViewController.h
//  MyFood
//
//  Created by qunlee on 16/8/8.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontStoreRequest.h"
#import "FontStoreColumnTableView.h"

@interface FontStoreViewController : UIViewController<FontStoreListDelegate, FootRefreshDelegate>{
    FontStoreColumnTableView *columnTab;
    FontStoreRequest *req;
}
@end
