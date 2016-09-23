//
//  CommUtls.h
//  UtlBox
//
//  Created by cdel cyx on 12-7-10.
//  Copyright (c) 2012年 cdeledu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ConstantUI.h"

typedef NS_ENUM(NSInteger, ImageFilterType) {
    /** 原图 */
    kImageFilterOriginalImage = 0,
    /** LOMO */
    kImageFilterLOMO = 1,
    /** 黑白 */
    kImageFilterBlackAndWhite = 2,
    /** 复古 */
    kImageFilterRetro = 3,
    /** 哥特 */
    kImageFilterGothic = 4,
    /** 锐化 */
    kImageFilterSharpColor = 5 ,
    /** 淡雅 */
    kImageFilterElegant = 6,
    /** 酒红 */
    kImageFilterBurgundy = 7 ,
    /** 青柠 */
    kImageFilterLime = 8 ,
    /** 浪漫 */
    kImageFilterRomantic = 9 ,
    /** 光晕 */
    kImageFilterHalo = 10 ,
    /** 蓝调 */
    kImageFilterBlues = 11 ,
    /** 梦幻 */
    kImageFilterDream = 12 ,
    /** 夜色 */
    kImageFilterNight = 13,
};

typedef NS_ENUM(NSInteger, ImageFilterTypeOfLock) {
    
    /** 原图 */
    kImageFilterOriginalImageOfLock,
    /** LOMO */
    kImageFilterLOMOOfLock,
    /** 蓝调 */
    kImageFilterBluesOfLock ,
    /** 哥特 */
    kImageFilterGothicOfLock,
    /** 夜色 */
    kImageFilterNightOfLock,
    /** 酒红 */
    kImageFilterBurgundyOfLock,
    /** 梦幻 */
    kImageFilterDreamOfLock ,
    /** 光晕 */
    kImageFilterHaloOfLock ,
    /** 淡雅 */
    kImageFilterElegantOfLock,
    /** 黑白 */
    kImageFilterBlackAndWhiteOfLock,
    /** 复古 */
    kImageFilterRetroOfLock,
    /** 锐化 */
    kImageFilterSharpColorOfLock,
    /** 青柠 */
    kImageFilterLimeOfLock ,
    /** 浪漫 */
    kImageFilterRomanticOfLock,

};

typedef NS_ENUM(NSInteger, UserType) {
    /**用户未登录/未获取到用类型*/
    kDefaultUserType = 0,
    /** 普通账号 */
    kOrdinaryAccount = 1,
    /** 企业账号 */
    kCorporateAccount = 2,
    /** 企业子账号 */
    kEnterpriseSubAccount = 21,
    /** 高级账户 */
    kSuperAccount = 3,
    /** 服务账号 */
    kServiceAccount = 4,
    /** 公共账号 */
    kPublicAccount = 5,
    /** 公共子账号 */
    kPublicSubAccount = 51,
    /** 运维账号 */
    kOperationAndMaintenanceAccount = 99,
};

typedef NS_ENUM(NSInteger, TopicType) {
    /** 个人专题 */
    kTopicTypePerson = 0,
    /** 企业专题 */
    kTopicTypeEnterprise = 1,
};

@interface CommUtls : NSObject

/*文件处理*/
//文件路径是否存在
+ (BOOL)fileExists:(NSString *)fullPathName;

//根据文件路径删除文件
+ (BOOL)remove:(NSString *)fullPathName;

//创建文件
+ (void)makeDirs:(NSString *)dir;

//documentPath路径是否存在
+ (BOOL)fileExistInDocumentPath:(NSString*)fileName;

//返回完整的documentPath下文件路径
+ (NSString*)documentPath:(NSString*)fileName;

//删除documentPath路径下文件
+ (BOOL)deleteDocumentFile:(NSString*)fileName;

//cachePath路径是否存在
+ (BOOL)fileExistInCachesPath:(NSString*)fileName;

//返回完整的cachePath下文件路径
+ (NSString*)cachesFilePath:(NSString*)fileName;

//删除cachePath下文件路径
+ (BOOL)deleteCachesFile:(NSString*)fileName;

/*时间处理*/
//CST时间格式转换
+ (NSString *)convertDateFromCST:(NSString *)_date;

//转换NSDate格式为字符串"yyyy-MM-dd HH:mm:ss"
+ (NSString *)encodeTime:(NSDate *)date;
+ (NSTimeInterval )timeSinceNowNSTimeInterval:(NSDate *)date;

//转换字符串为"yyyy-MM-dd HH:mm:ss"格式到NSDate
+ (NSDate *)dencodeTime:(NSString *)dateString;

//装换NSDate格式到NString
+ (NSString *)encodeTime:(NSDate *)date format:(NSString *)format;

//转换NString到NSdate
+ (NSDate *)dencodeTime:(NSString *)dateString format:(NSString *)format;

//从现在到某天的时间
+ (NSString *)timeSinceNow:(NSDate *)date;

//把秒转化为时间字符串显示，播放器常用
+ (NSString *)changeSecondsToString:(CGFloat)durartion;

/*跳转处理*/
//跳转到电子市场页面
+ (void)goToAppStoreHomePage:(NSInteger)appid;

//跳转到电子市场评论页面
+ (void)goToAppStoreCommentPage:(NSInteger)appid;

//跳到短信页面
+ (void)goToSmsPage:(NSString*)phoneNumber;

//打开浏览器
+ (void)openBrowse:(NSString*)url;

//打开EMAIL
+ (void)openEmail:(NSString*)email;

//拨打电话
+ (void)goToTelephone:(NSString *)phoneNumber;

/*其他处理*/
//返回字节大小
+ (NSString*)getSize:(NSNumber*)number;

//获取空余磁盘信息
+ (CGFloat)freeDiskSpace;

//返回随即数
+ (NSInteger)getRandomNumber:(NSInteger)min maxNumber:(NSInteger)max;

//转换颜色色值
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
//转换颜色色值，有透明度
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert withAlpha:(CGFloat)alpha;

+ (NSString *)changeUIColorToRGB:(UIColor *)color;

//返回UILabel高度
+ (CGFloat)returnHeightFloat:(NSString *)str frontSize:(UIFont*)front frontWidth:(CGFloat)frontwidth;

//返回label长度
+(CGFloat)returnWidthWithLabel:(NSString *)string frontSize:(CGFloat )frontSize maxSize:(CGSize)maxSize;

//是否存在网络
+ (BOOL)checkConnectNet;

/*UI组件*/
//状态栏添加信息
+ (void)addStatusMessage:(NSString*)message afterTime:(CGFloat)time;

//删除信息
+ (void)removeStatusMessage;

//图片压缩
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

//图片方向
+ (UIImage *)fixOrientation:(UIImage *)aImage;

//图片裁剪
+ (UIImage *)cropImageWithRect:(CGRect)newImageSize image:(UIImage *)image;

//把当前view生成图片 并压缩  compress 压缩倍数 0~1
+ (UIImage *)changeViewToImage:(UIView *)currentView compress:(CGFloat)compress;


//增加icloud不被备份
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

//抖动
+ (void)shakeAnimationForView:(UIView *)shakeView;
//邮箱合法验证
+ (BOOL)validateEmail:(NSString *)email;
+ (BOOL)validatePassword:(NSString *)passWord;
//电话合法验证
+ (BOOL)validatePhoneNum:(NSString *)phoneNum;

+ (void)initLocalNotifictionWithDate:(NSDate *)date userInfo:(NSDictionary *)userInfo message:(NSString *)message;
+ (void)deleteSingleNotificationWithRemarkId:(NSInteger)remarkId;

//判断长度 这里把2位字符转出1位来计算
+ (NSUInteger) lenghtWithString:(NSString *)string;

//完全拷贝  包括地址和内容
+ (id)totalCopyOneItem:(id)oldItem;

+ (NSObject *)initPropertyWithClass:(NSObject *)infoObject fromDic:(NSDictionary *)jsonDic;

//拷贝字符串至剪切板
+ (void)copyStringWithString:(NSString *)needCopyStr;

//打开Safari
+ (void)openSafariWithUrl:(NSString *)urlStr;


//数组排序（正序）
+ (void)sortArrayWithSortArray:(NSMutableArray *)arry;

//字典排序（正序）这是按照values的排序 返回值是排序好的keys
+ (NSArray *)sortDicWithSortDictionary:(NSMutableDictionary *)dic;
//获取随机色值字符串
+ (NSString *)getRandomColorString;

/** 自定义的字体 */
+ (UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size;

+ (id)getUserPreferenceObjectForKey:(NSString *)key;

+ (void)saveUserPreferenceObject:(NSObject *)object forKey:(NSString *)key;
@end
