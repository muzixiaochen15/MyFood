//
//  MemoryManagementController.h
//  MyFood
//
//  Created by qunlee on 16/8/23.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestDelegate <NSObject>
@optional
- (void)testAction;

@end

@interface MemoryManagementController : UIViewController

/** block test */
@property (nonatomic, copy, nullable) void (^doDuff)(NSString * _Nullable string);

@property (nonatomic, nullable, assign) id<TestDelegate> delegate;

@end
