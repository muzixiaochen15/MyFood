//
//  SNLoading.h
//  MyFood
//
//  Created by qunlee on 16/9/9.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNLoading : NSObject
+ (void)showWithTitle:(NSString *)title;
+ (void)hideWithTitle:(NSString *)title;
+ (void)updateWithTitle:(NSString *)title withDetailsText:(NSString *)detailsText;
@end
