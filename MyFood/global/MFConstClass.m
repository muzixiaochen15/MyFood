//
//  MFConstClass.m
//  MyFood
//
//  Created by qunlee on 16/8/25.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "MFConstClass.h"
#import <objc/runtime.h>

@interface MFConstClass ()
{
    ///网络状态
    Reachability *reach;
}
@end

@implementation MFConstClass

+ (UIColor *)getRandomColor{
    CGFloat red = arc4random_uniform(255)/255.0f;
    CGFloat green = arc4random_uniform(255)/255.0f;
    CGFloat blue = arc4random_uniform(255.0f)/255.0f;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    return color;
}

+ (NSArray *)getPropertiesOfObject:(id)object{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    NSMutableArray *ptrArray = [[NSMutableArray alloc]initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *properyName = [NSString stringWithUTF8String:property_getName(property)];
        [ptrArray addObject:properyName];
    }
    free(properties);
    return ptrArray;
}

+ (NSArray *)getVariableNameOfObject:(id)object{
    unsigned int numIvars = 0;
    Ivar *ivars = class_copyIvarList([object class], &numIvars);
    NSMutableArray *ivarNameArray = [[NSMutableArray alloc]initWithCapacity:numIvars];
    for (int i = 0; i < numIvars; i++) {
        Ivar var = ivars[i];
        const char *type = ivar_getTypeEncoding(var);
        NSString *stringType = [NSString stringWithUTF8String:type];
        if (![stringType hasPrefix:@"@"]) {
            continue;
        }
        NSString *varName = [NSString stringWithUTF8String:ivar_getName(var)];
        [ivarNameArray addObject:varName];
    }
    free(ivars);
    return ivarNameArray;
}
+ (NSObject *)initPropertyWithClass:(NSObject *)object fromDic:(NSDictionary *)dic{
    unsigned int numIvars = 0;
    objc_property_t *properties = class_copyPropertyList([object class], &numIvars);
    for (int i = 0; i < numIvars; i++) {
        objc_property_t property = properties[i];
        const char *varname = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:varname];
        id valueObj = [dic valueForKey:propertyName];
        if (![valueObj isKindOfClass:[NSNull class]]&&valueObj != nil) {
            [object setValue:valueObj forKey:propertyName];
        }
    }
    free(properties);
    return object;
}
+ (NSMutableArray *)parseListWithItemClassName:(NSString *)className withList:(NSArray *)array{
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    if ([className isEqualToString:@"NSNull"]||!array) {
        return nil;
    }
    Class TempClass = NSClassFromString(className);
    for (NSDictionary *subDic in array) {
        id obj = [[TempClass alloc]init];
        [MFConstClass initPropertyWithClass:obj fromDic:subDic];
        [dataArray addObject:obj];
    }
    return dataArray;
}
static NSString *TEST_NETWORK_HOST = @"www.baidu.com";
- (void)getNetworkStatus{
    reach = [Reachability reachabilityWithHostName:TEST_NETWORK_HOST];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(reachabilityChanged)
                                                name:kReachabilityChangedNotification
                                              object:nil];
    [reach startNotifier];
}
- (NetworkStatus)reachabilityChanged{
    NetworkStatus status = [reach currentReachabilityStatus];
    return status;
}
@end
