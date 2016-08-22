//
//  EQXDataUtils.m
//  MyFood
//
//  Created by qunlee on 16/8/5.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "EQXDataUtils.h"

@implementation EQXDataUtils
+ (EQXDataUtils *)shareInstance{
    static dispatch_once_t once;
    static EQXDataUtils *__singleton__;;
    dispatch_once(&once, ^{
        __singleton__ = [[EQXDataUtils alloc]init];
    });
    return __singleton__;
}
- (void)startSqlite{
    
}
@end
