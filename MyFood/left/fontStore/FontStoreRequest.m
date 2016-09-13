//
//  FontStoreRequest.m
//  MyFood
//
//  Created by qunlee on 16/8/10.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "FontStoreRequest.h"

@implementation FontStoreRequest
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)jsonToObjectWithDict:(NSDictionary *)dict{
    if (_delegate) {
        [_delegate refreshFontStoreListWithDict:dict];
    }
}
- (void)getFontStoreList{
    [self performSelector:@selector(jsonToObjectWithDict:) withObject:nil afterDelay:0.1f];
}
- (void)getMyFontList{
    
}

@end
