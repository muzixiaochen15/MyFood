//
//  FontStoreRequest.h
//  MyFood
//
//  Created by qunlee on 16/8/10.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FontStoreListDelegate <NSObject>

- (void)refreshFontStoreListWithDict:(NSDictionary *)dict;

@end

@interface FontStoreRequest : NSObject
/** 字体商城列表 */
@property (nonatomic, assign) id<FontStoreListDelegate> delegate;
- (void)getFontStoreList;
- (void)getMyFontList;

@end
