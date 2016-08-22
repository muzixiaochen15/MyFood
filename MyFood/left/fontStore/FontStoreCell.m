//
//  FontStoreCell.m
//  MyFood
//
//  Created by qunlee on 16/8/8.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "FontStoreCell.h"
#import "FontPriceTipView.h"

@implementation FontStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_xiuFontLabel.layer setBorderColor:[UIColor whiteColor].CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)personalBuyButtonClicked:(id)sender {
    FontPriceTipView *tip = [[FontPriceTipView alloc]init];
    [tip show];

}

- (IBAction)businessBuyButtonClicked:(id)sender {
    FontPriceTipView *tip = [[FontPriceTipView alloc]init];
    [tip show];

}
@end
