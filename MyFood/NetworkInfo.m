//
//  NetworkInfo.m
//  MyFood
//
//  Created by qunlee on 16/8/5.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "NetworkInfo.h"
#import "AFNetworking.h"

@implementation NetworkInfo

+ (BOOL)getNetworkStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                //网络不可用
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //移动网
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //wifi
                break;
            default:
                //未知网络状态
                break;
        }
    }];
    return manager.isReachable;
}

@end
