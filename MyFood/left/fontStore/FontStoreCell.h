//
//  FontStoreCell.h
//  MyFood
//
//  Created by qunlee on 16/8/8.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontStoreCell : UITableViewCell
/** “秀”字 */
@property (weak, nonatomic) IBOutlet UILabel *xiuFontLabel;

@property (weak, nonatomic) IBOutlet UIButton *businessButton;

@property (weak, nonatomic) IBOutlet UIButton *personalButton;
- (IBAction)personalBuyButtonClicked:(id)sender;
- (IBAction)businessBuyButtonClicked:(id)sender;

@end
