//
//  ConstantUI.h
//  YiQiXiu
//
//  Created by Sherry on 14-10-14.
//  Copyright (c) 2014年 Sherry. All rights reserved.
//

#ifndef YiQiXiu_ConstantUI_h
#define YiQiXiu_ConstantUI_h

#ifdef DEBUG
#define CLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define CLog(format, ...)
#endif

#define IsIOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
#define IsIOS9 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0)

#define NAVIGATIONBAR_HEIGHT 65
#define TOPBAR_HEIGHT 40

// screen的宽度
#define WIDTH_OF_SCREEN [[UIScreen mainScreen] bounds].size.width
// screen的高度
#define HEIGHT_OF_SCREEN [[UIScreen mainScreen] bounds].size.height

#define KScreenSize [[UIScreen mainScreen] bounds].size

typedef enum _NetWorkCondition{
    NetWorkConditionUnknown                                            = -1,
    NetWorkConditionNotReachable                                       = 0,
    NetWorkCondition3G                                                 = 1,
    NetWorkConditionWifi                                               = 2,
}NetWorkCondition;


typedef NS_ENUM(NSInteger, ScreenSize) {
    Iphone4s = 960,
    Iphone5s = 1136,
    Iphone6 = 1334,
    Iphone6Plus = 1472,
};

#define kClientTableCellHeight         60
#define kListClientTableCellHeight     70
#define kSceneClientTableCellHeight    60
#define kClinetDetailViewCellHeight    55
#define kSceneDetailViewCellHeight     50
#define kSceneViewCellHeight           154
#define kSceneSampleViewCellHeight     190   //由图片比例算出
#define kContactTableCellHeight        50
#define kRemarkTableCellHeight         60
#define kDataSpreadTableCellHeight     40
#define kUserCenterTableCellHeight     50
#define kMaterialTableCellHeight       110
#define kSceneCreateTableCellHeight    50

#define kMainTitleSize                 18
#define kTitleSize                     16
#define kContentSize                   14
#define kDetailSize                    12
#define kDateSize                      10
#define kBasicViewTableHeight          50

#define kStatisticsKey                @"9c76f62ebc"
#define kWeiXinAppKey                 @"wx981a6a055dee4b5a"
#define kWeiXinSecret                 @"93b42bf142b2ea46e41f0076731422b7"

#define kWeiBoAppKey                  @"1113259712"
#define kWeiBoSecret                  @"cd5bfadf5e848b24f3d80bd8975c0784"

#define kQQAppKey                     @"101149132"
#define kQQSecret                     @"5056ba763fe7c22a45b90fdd10d1d559"

#define kFacebookAppKey               @"840352739366416"

#define kClientDetailViewMobileStr    @"添加电话"
#define kClientDetailViewEmailStr     @"添加邮箱"

#define kTopBarColorStr               @"#31344b"
#define kMainColorStr                 @"#56c6ff"
#define kBackColorStr                 @"#f4f4f4"
#define kMainTitleColorStr            @"#666666"
#define kDescTitleColorStr            @"#9b9b9b"
#define KTitleColorStr                @"#333333"
#define  kDefaultImageColorCount      10

#define  DefaultImageColorType_0      @"ceecff";
#define  DefaultImageColorType_1      @"e7fff1";
#define  DefaultImageColorType_2      @"eeebff";
#define  DefaultImageColorType_3      @"f6ffeb";
#define  DefaultImageColorType_4      @"ffe7e7";
#define  DefaultImageColorType_5      @"dfe7ff";
#define  DefaultImageColorType_6      @"f7ffe7";
#define  DefaultImageColorType_7      @"ffdadb";
#define  DefaultImageColorType_8      @"ebfffd";
#define  DefaultImageColorType_9      @"fff1e7";


#define kFailureDays                  7

#define kGuideViewNum                 3

#define kAppLanguageChange            @"AppLanguageChanged"
#define kAppExitLogin                 @"AppExitLoginNow"
#define kLoginOrRegiterSucced         @"LoginOrRegiterSucced"

#import "CommUtls.h"

#endif
