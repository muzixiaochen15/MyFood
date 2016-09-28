//
//  jokeTableViewCell.h
//  MyFood
//
//  Created by qunlee on 16/9/14.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FunnyItem;
@interface JokeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *jokeTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *approveButton;
@property (weak, nonatomic) IBOutlet UIButton *disapproveButton;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
- (IBAction)shareButton:(id)sender;
- (void)updateCellWithItem:(FunnyItem *)item;
@end
