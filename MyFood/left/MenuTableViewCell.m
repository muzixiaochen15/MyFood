//
//  MenuTableViewCell.m
//  MyFood
//
//  Created by qunlee on 16/8/8.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "UIColor+CustomColors.h"
#import "POPBasicAnimation.h"
#import "POPSpringAnimation.h"
#import <PureLayout/PureLayout.h>

@implementation MenuTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _showCharLabel = [UILabel newAutoLayoutView];
        _showCharLabel.backgroundColor = [UIColor lightGrayColor];
        _showCharLabel.textColor = [UIColor whiteColor];
        _showCharLabel.textAlignment = NSTextAlignmentCenter;
        _showCharLabel.font = [UIFont boldSystemFontOfSize:80];
        [self addSubview:_showCharLabel];
        [_showCharLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 20.0f) excludingEdge:ALEdgeRight];
        [_showCharLabel autoSetDimension:ALDimensionWidth toSize:100.0f];
        
        _menuTitleLabel = [UILabel newAutoLayoutView];
        _menuTitleLabel.backgroundColor = [UIColor clearColor];
        _menuTitleLabel.textColor = [UIColor lightGrayColor];
        _menuTitleLabel.textAlignment = NSTextAlignmentLeft;
        _menuTitleLabel.numberOfLines = 0;
        _menuTitleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:25];
        [self addSubview:_menuTitleLabel];
        [_menuTitleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 120.0f, 0.0f, 20.0f)];
        
//        self.textLabel.textColor = [UIColor customGrayColor];
//        self.textLabel.userInteractionEnabled = NO;
//        self.textLabel.backgroundColor = [UIColor clearColor];
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (self.highlighted) {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration = 0.1;
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self.textLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    } else {
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnimation.springBounciness = 20.f;
        [self.textLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
}

@end
