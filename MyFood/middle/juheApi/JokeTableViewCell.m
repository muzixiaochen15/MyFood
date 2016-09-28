//
//  jokeTableViewCell.m
//  MyFood
//
//  Created by qunlee on 16/9/14.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "JokeTableViewCell.h"
#import "EQXColor.h"
#import "ShareClass.h"
#import "FunnyItem.h"

@implementation JokeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImage *bgImage = [UIImage imageNamed:@"duanzi_button_normal"];
    //40 X 30
    bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(10.0f, 20.0f, 10.0f, 20.0f) resizingMode:UIImageResizingModeStretch];
    [_approveButton setBackgroundImage:bgImage forState:UIControlStateNormal];
    [_disapproveButton setBackgroundImage:bgImage forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)updateCellWithItem:(FunnyItem *)item{
    NSString *numStr = [NSString stringWithFormat:@"%lu", item.approveNum];
    [_approveButton setTitle:numStr forState:UIControlStateNormal];
    [_disapproveButton setTitle:@"123" forState:UIControlStateNormal];
    [_jokeTitleLabel setAttributedText:item.titleAttr];
}
- (IBAction)shareButton:(id)sender {
    [ShareClass share];
}
@end
