//
//  LeftViewController.h
//  MyFood
//
//  Created by qunlee on 16/8/8.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LeftViewController : UITableViewController
/** 
 *  weak 引用无法retain对象，strong会使retainCount + 1
 */
@property (nonatomic, strong) NSString *testObject;

@end
