//
//  MiddleCollectionCell.m
//  MyFood
//
//  Created by qunlee on 16/9/14.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "MiddleCollectionCell.h"
#import "PureLayout/PureLayout.h"
#import "pop/POPBasicAnimation.h"
#import "pop/POPSpringAnimation.h"
#import "MFConstClass.h"
#import "EQXColor.h"

@implementation MiddleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
- (void)configureViews{

}
- (UIButton *)textButton{
    if (!_textButton) {
        _textButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _textButton.userInteractionEnabled = NO;
        _textButton.backgroundColor = [MFConstClass getRandomColor];
        [_textButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_textButton.titleLabel setFont:[UIFont fontWithName:@"FZY3K--GB1-0" size:16.0f]];
        [self.contentView addSubview:_textButton];
        [_textButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)];
    }
    return _textButton;
}
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (highlighted) {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration = 0.1f;
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95f, 0.95f)];
        [_textButton pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        [_textButton setBackgroundColor:[EQXColor colorWithHexString:@"#000000" withAlpha:0.7f]];
    }else{
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0f, 1.0f)];
        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2.0f, 2.0f)];
        scaleAnimation.springBounciness = 20.0;
        [_textButton pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        _textButton.backgroundColor = [MFConstClass getRandomColor];
    }
}
@end
