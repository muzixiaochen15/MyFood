//
//  BindPhoneTip.m
//  MyFood
//
//  Created by qunlee on 16/12/13.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "BindPhoneTip.h"
#import <PureLayout/PureLayout.h>

@implementation BindPhoneTip

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *leftImageView = [UIImageView newAutoLayoutView];
        leftImageView.backgroundColor = [UIColor orangeColor];
        [self addSubview:leftImageView];
        [leftImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f) excludingEdge:ALEdgeRight];
        [leftImageView autoSetDimension:ALDimensionWidth toSize:30.0f];
        
        UILabel *middleLabel = [UILabel newAutoLayoutView];
        middleLabel.backgroundColor = [UIColor clearColor];
        middleLabel.font = [UIFont systemFontOfSize:13.0f];
        middleLabel.text = @"为了你的账号安全，请及时绑定手机号";
        [self addSubview:middleLabel];
        [middleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 30.0f, 0.0f, 30.0f)];
        
        UIImageView *rightImageView = [UIImageView newAutoLayoutView];
        rightImageView.backgroundColor = [UIColor orangeColor];
        [self addSubview:rightImageView];
        [rightImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f) excludingEdge:ALEdgeLeft];
        [rightImageView autoSetDimension:ALDimensionWidth toSize:30.0f];
    }
    return self;
}

@end
