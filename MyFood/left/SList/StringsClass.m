//
//  StringsClass.m
//  MyFood
//
//  Created by qunlee on 16/8/30.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "StringsClass.h"
@interface StringsClass(){
    NSString *localStr;
}
@end
@implementation StringsClass
- (instancetype)init{
    if (self = [super init]) {
        _readWriteStr = @"0123";
        _readonlyStr = @"0123";
    }
    return self;
}
- (void)setString:(NSString *)testStr{
    localStr = testStr;
}
- (NSString *)getString{
    return localStr;
}
@end
