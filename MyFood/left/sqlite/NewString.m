//
//  NewString.m
//  MyFood
//
//  Created by qunlee on 16/8/29.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "NewString.h"

@implementation NewString

- (instancetype)initWithChars:(char*)chars encoding:(NSStringEncoding)encoding{
    NewString *obj;
    obj = [NewString allocWithZone:NSDefaultMallocZone()];
    obj = [obj initWithChars:chars encoding:encoding];
    return obj;
}

@end
