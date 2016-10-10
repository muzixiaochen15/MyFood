//
//  WordDetailViewController.h
//  MyFood
//
//  Created by qunlee on 16/10/8.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordDetailViewController : UIViewController

@property (nonatomic, strong) NSString *wordName;
@property (nonatomic, strong) NSString *wordDetail;

@property (weak, nonatomic) IBOutlet UILabel *wordNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordDetailLabel;

@end
