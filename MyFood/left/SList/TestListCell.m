//
//  TestListCell.m
//  MyFood
//
//  Created by qunlee on 16/8/29.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "TestListCell.h"
#import "PureLayout/PureLayout.h"
#import "View+MASAdditions.h"
#import "EQXColor.h"

@implementation TestListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addTestLabel];
        [self addProcessView];
    }
    return self;
}
- (void)addTestLabel{
    _listTitleLabel = [UILabel newAutoLayoutView];
    _listTitleLabel.backgroundColor = [UIColor clearColor];
    _listTitleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0f];
    _listTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_listTitleLabel];
    [_listTitleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5.0f, 20.0f, 5.0f, 100.0f)];
}
- (void)addProcessView{
    self.proview = [UIProgressView new];
    //    self.proview.progress = [investitem.percent floatValue]/100;
    self.proview.layer.cornerRadius = 5;
    self.proview.clipsToBounds = YES;
    if (self.proview.progress == 1) {
        self.proview.progressTintColor = [EQXColor colorWithHexString:@"#bbbbbb"];
    }
    self.proview.progressTintColor = [EQXColor colorWithHexString:@"#50b440"];
    self.proview.trackTintColor = [EQXColor colorWithHexString:@"#e1e2e3"];
    self.proview.progress = 0.0f;
    
    [self.contentView addSubview:self.proview];
    [self.proview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_listTitleLabel.mas_centerY);
        make.left.equalTo(_listTitleLabel.mas_right).with.offset(5.0f);
        make.width.equalTo(@50);
        make.height.equalTo(@11);
    }];
}
@end
