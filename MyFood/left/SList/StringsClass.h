//
//  StringsClass.h
//  MyFood
//
//  Created by qunlee on 16/8/30.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringsClass : NSObject
//nonatomic 非原子特性,多线程并发提高性能。尽量少用atomic
/** 自定义set、get方法 */
@property (nonatomic, getter=getString,setter=setString:) NSString *testStr;
/** 默认，读写 */
@property (nonatomic, readwrite) NSString *readWriteStr;
/** 外部不能调用赋值操作 */
@property (nonatomic, readonly) NSString *readonlyStr;
/** 不存在计数器 */
@property (nonatomic, assign) NSInteger *assgnStr;
/** release旧值，retain 新值 */
@property (nonatomic, retain) NSString *retainStr;
/** 复制对象 */
@property (nonatomic, copy) NSString *scopyStr;

@end
