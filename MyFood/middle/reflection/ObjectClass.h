//
//  ObjectClass.h
//  MyFood
//
//  Created by qunlee on 16/9/20.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectClass : NSObject

@property (nonatomic, assign) NSUInteger id;

@property (nonatomic, strong) NSString *objTitle;

@property (nonatomic, strong) NSString *objDesc;

@property (nonatomic, strong) NSArray *objArray;

@end
