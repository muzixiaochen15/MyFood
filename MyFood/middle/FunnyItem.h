//
//  FunnyItem.h
//  MyFood
//
//  Created by qunlee on 16/9/23.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunnyItem : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *valid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSAttributedString *titleAttr;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) NSUInteger approveNum;
@property (nonatomic, assign) BOOL isApprove;
@property (nonatomic, assign) BOOL isDisapprove;
@end
