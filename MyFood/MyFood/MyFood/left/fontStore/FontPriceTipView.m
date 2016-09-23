//
//  FontPriceTipView.m
//  MyFood
//
//  Created by qunlee on 16/8/10.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "FontPriceTipView.h"
#import "PureLayout.h"
#import "EQXColor.h"

@interface FontPriceTipView()

@property (nonatomic, strong) UIImageView *alertView;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation FontPriceTipView
@synthesize alertView;

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    }
    return self;
}
- (void)show{
    [self createTipView];
    __weak FontPriceTipView *weakSelf = self;
    [[[UIApplication sharedApplication].windows firstObject] addSubview:self];
    alertView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    alertView.alpha = 0.0f;
    _closeButton.hidden = YES;
    [UIView animateWithDuration:0.6
                          delay:0
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (weakSelf) {
                             weakSelf.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
                             weakSelf.alertView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                             weakSelf.alertView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                             weakSelf.alertView.alpha = 1.0f;
                         }
    } completion:^(BOOL finished) {
        if (finished) {
            _closeButton.hidden = NO;
        }
    }];
}
- (void)close{
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         self.alertView.alpha = 0.0f;
                         self.closeButton.alpha = 0.0f;
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}
- (void)createTipView{
    alertView = [UIImageView newAutoLayoutView];
    alertView.image = [UIImage imageNamed:@"升级弹窗背景"];
    alertView.userInteractionEnabled = YES;
    [self addSubview:alertView];
    [alertView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [alertView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [alertView autoSetDimensionsToSize:CGSizeMake(305.0f, 247.0f)];
    
    UILabel *personalTitleLabel = [UILabel newAutoLayoutView];
    personalTitleLabel.backgroundColor = [UIColor clearColor];
    personalTitleLabel.textColor = [EQXColor colorWithHexString:@"#37474f"];
    personalTitleLabel.textAlignment = NSTextAlignmentCenter;
    personalTitleLabel.font = [UIFont systemFontOfSize:17.0f];
    personalTitleLabel.text = @"个人版";
    [alertView addSubview:personalTitleLabel];
    [personalTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25.0f];
    [personalTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:82.0f];
    [personalTitleLabel autoSetDimensionsToSize:CGSizeMake(95.0f, 20.0f)];
    
    UILabel *personalDetailLabel = [UILabel newAutoLayoutView];
    personalDetailLabel.backgroundColor = [UIColor clearColor];
    personalDetailLabel.text = @"仅用于个人制作使用";
    personalDetailLabel.textAlignment = NSTextAlignmentCenter;
    personalDetailLabel.font = [UIFont systemFontOfSize:12.0f];
    personalDetailLabel.textColor = [EQXColor colorWithHexString:@"#37474f"];
    [alertView addSubview:personalDetailLabel];
    [personalDetailLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5.0f];
    [personalDetailLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:107.0f];
    [personalDetailLabel autoSetDimensionsToSize:CGSizeMake(142.0f, 15.0f)];
    
    UIButton *personalPriceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    personalPriceBtn.translatesAutoresizingMaskIntoConstraints = NO;
    personalPriceBtn.backgroundColor = [EQXColor colorWithHexString:@"#ffb361"];
    [personalPriceBtn setTitle:@"10秀点" forState:UIControlStateNormal];
    [personalPriceBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [personalPriceBtn.layer setMasksToBounds:YES];
    [personalPriceBtn.layer setCornerRadius:4.0f];
    [personalPriceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [personalPriceBtn addTarget:self action:@selector(personalPriceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:personalPriceBtn];
    [personalPriceBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:alertView withOffset:31.0f];
    [personalPriceBtn autoAlignAxis:ALAxisVertical toSameAxisOfView:alertView withOffset:-78.0f];
    [personalPriceBtn autoSetDimensionsToSize:CGSizeMake(111.0f, 30.0f)];
    
    UILabel *businessTitleLabel = [UILabel newAutoLayoutView];
    businessTitleLabel.backgroundColor = [UIColor clearColor];
    businessTitleLabel.textColor = [EQXColor colorWithHexString:@"#37474f"];
    businessTitleLabel.textAlignment = NSTextAlignmentCenter;
    businessTitleLabel.font = [UIFont systemFontOfSize:17.0f];
    businessTitleLabel.text = @"商业版";
    [alertView addSubview:businessTitleLabel];
    [businessTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:25.0f];
    [businessTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:82.0f];
    [businessTitleLabel autoSetDimensionsToSize:CGSizeMake(95.0f, 20.0f)];
    
    UILabel *businessDetailLabel = [UILabel newAutoLayoutView];
    businessDetailLabel.backgroundColor = [UIColor clearColor];
    businessDetailLabel.text = @"可用于商业制作传播";
    businessDetailLabel.textAlignment = NSTextAlignmentCenter;
    businessDetailLabel.font = [UIFont systemFontOfSize:12.0f];
    businessDetailLabel.textColor = [EQXColor colorWithHexString:@"#37474f"];
    [alertView addSubview:businessDetailLabel];
    [businessDetailLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5.0f];
    [businessDetailLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:107.0f];
    [businessDetailLabel autoSetDimensionsToSize:CGSizeMake(142.0f, 15.0f)];
    
    UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    businessBtn.translatesAutoresizingMaskIntoConstraints = NO;
    businessBtn.backgroundColor = [EQXColor colorWithHexString:@"#ffb361"];
    [businessBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [businessBtn setTitle:@"99秀点" forState:UIControlStateNormal];
    [businessBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [businessBtn.layer setMasksToBounds:YES];
    [businessBtn.layer setCornerRadius:4.0f];
    [businessBtn addTarget:self action:@selector(businessPriceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:businessBtn];
    [businessBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:alertView withOffset:31.0f];
    [businessBtn autoAlignAxis:ALAxisVertical toSameAxisOfView:alertView withOffset:78.0f];
    [businessBtn autoSetDimensionsToSize:CGSizeMake(111.0f, 30.0f)];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.backgroundColor = [UIColor clearColor];
    _closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_closeButton setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:_closeButton];
    [_closeButton autoSetDimensionsToSize:CGSizeMake(22.0f, 22.0f)];
    [_closeButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:alertView withOffset:0.0f];
    [_closeButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:alertView withOffset:-9.0f];
}
- (void)personalPriceBtnClicked:(UIButton *)button{
}
- (void)businessPriceBtnClicked:(UIButton *)button{
}
- (void)closeButtonClicked:(UIButton *)button{
    [self close];
}
@end
