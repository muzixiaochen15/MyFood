//
//  CollectionCell.m
//  MyFood
//
//  Created by qunlee on 16/11/8.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "CollectionCell.h"
#import "PureLayout/PureLayout.h"

@implementation CollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.backgroundColor = [UIColor clearColor];
        [_btn setTitle:@"正则表达式" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        _btn.userInteractionEnabled = NO;
        [_btn.titleLabel setNumberOfLines:0];
        [self addSubview:_btn];
        [_btn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.5f, 0.5f, 0.5f, 0.5f)];
        
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}
@end
