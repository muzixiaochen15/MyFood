//
//  SNLoading.m
//  MyFood
//
//  Created by qunlee on 16/9/9.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "SNLoading.h"
#import "MBProgressHUD/MBProgressHUD.h"

static MBProgressHUD *progressHud = nil;
@implementation SNLoading

+ (void)showWithTitle:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!progressHud) {
            [progressHud removeFromSuperview];
            progressHud = nil;
        }
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        progressHud = [[MBProgressHUD alloc]initWithView:window];
        progressHud.label.text = title? title:GBLocalizedString(@"loading");
        progressHud.removeFromSuperViewOnHide = YES;
        [window addSubview:progressHud];
        [progressHud showAnimated:YES];
        [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    });
}

+ (void)hideWithTitle:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
        progressHud.label.text = title ? title :GBLocalizedString(@"loaded");
        [progressHud hideAnimated:YES];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    });
}

+ (void)updateWithTitle:(NSString *)title withDetailsText:(NSString *)detailsText{
    progressHud.label.text = title ? title: GBLocalizedString(@"loading");
    progressHud.detailsLabel.text = detailsText;
}
@end
