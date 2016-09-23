//
//  CommonDefine.h
//  MyFood
//
//  Created by qunlee on 16/9/9.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

#import <AVFoundation/AVFoundation.h>
#import "SNLoading.h"

#define IOS7  [[UIDevice currentDevice].systemVersion floatValue] >= 7.0f
#define Screen_Width     [[UIScreen mainScreen] bounds].size.width
#define Screen_Height   [[UIScreen mainScreen] bounds].size.height
#define JUHEKEY  
#pragma mark - App info
static inline NSString *getAppVersion(){
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *versonNum = infoDict[@"CFBundleVersion"];
    return versonNum;
}

static inline NSString *getAppName(){
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = infoDict[@"CFBundleDisplayName"];
    return appName;
}
#define CURR_LANG ([[NSLocale preferredLanguages] objectAtIndex: 0])
static inline NSString *GBLocalizedString(NSString *translation_key){
    NSString *string = NSLocalizedString(translation_key, nil);
    if (![CURR_LANG isEqual:@"en"]&&![CURR_LANG hasPrefix:@"zh-Hans"]) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"en" ofType:@"lproj"];
        NSBundle *languageBundle = [NSBundle bundleWithPath:path];
        string = [languageBundle localizedStringForKey:translation_key value:@"" table:nil];
    }
    return string;
}

#endif /* CommonDefine_h */
