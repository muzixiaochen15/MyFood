//
//  CommUtls.m
//  UtlBox
//
//  Created by cdel cyx on 12-7-10.
//  Copyright (c) 2012年 cdeledu. All rights reserved.
//

#import "CommUtls.h"
#import  <dlfcn.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#import  <CommonCrypto/CommonCryptor.h>
#import  <SystemConfiguration/SystemConfiguration.h>
#import <objc/runtime.h>
#import <CoreText/CoreText.h>
//#import "PhotoSelectMethod.h"

@implementation CommUtls


//根据info属性名赋值
+ (NSObject *)initPropertyWithClass:(NSObject *)infoObject fromDic:(NSDictionary *)jsonDic
{
    unsigned int outCount ;
    objc_property_t *properties = class_copyPropertyList([infoObject class], &outCount);
    for (int i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        NSString *propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        id valueObj = [jsonDic valueForKey:propertyNameStr];
        if (![valueObj isKindOfClass:[NSNull class]] && valueObj != nil)
        {
            [infoObject setValue:valueObj forKey:propertyNameStr];
        }
    }
    free(properties);
    return infoObject;
}

+ (NSString *)getRandomColorString{
    
    int randomColorIndex = arc4random()% kDefaultImageColorCount;

    switch (randomColorIndex) {
        case 0:
        {
            return DefaultImageColorType_0;
        }
            break;
        case 1:
        {
            return DefaultImageColorType_1;
        }
            break;
        case 2:
        {
            return DefaultImageColorType_2;
        }
            break;
        case 3:
        {
            return DefaultImageColorType_3;
        }
            break;
        case 4:
        {
            return DefaultImageColorType_4;
        }
            break;
        case 5:
        {
            return DefaultImageColorType_5;
        }
            break;

        case 6:
        {
            return DefaultImageColorType_6;
        }
            break;
            
        case 7:
        {
            return DefaultImageColorType_7;
        }
            break;
            
        case 8:
        {
            return DefaultImageColorType_8;
        }
            break;
            
        case 9:
        {
            return DefaultImageColorType_9;
        }
            break;

        default:
        {
            return DefaultImageColorType_3;
        }
            break;
    }
}


/**
 *	@brief	判断文件路径是否存在
 *
 *	@param 	fullPathName 	文件完整路径
 *
 *	@return	返回是否存在
 */
+ (BOOL)fileExists:(NSString *)fullPathName
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:fullPathName];
}

/**
 *	@brief	删除文件
 *
 *	@param 	fullPathName 	文件完整路径
 *
 *	@return	是否删除成功
 */
+ (BOOL)remove:(NSString *)fullPathName
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    if ([file_manager fileExistsAtPath:fullPathName]) {
        [file_manager removeItemAtPath:fullPathName error:nil];
    }
   
    return YES;
}

/**
 *	@brief	创建文件夹
 *
 *	@param 	dir 	文件夹名字
 */
+ (void)makeDirs:(NSString *)dir
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    [file_manager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
}

/**
 *	@brief	判断Document文件路径是否存在
 *
 *	@param 	fileName 	文件名
 *
 *	@return	返回是否存在文件路径
 */
+ (BOOL)fileExistInDocumentPath:(NSString*)fileName

{
	if(fileName == nil)
		return NO;
	NSString* documentsPath = [self documentPath:fileName];
	return [[NSFileManager defaultManager] fileExistsAtPath: documentsPath];
}

/**
 *	@brief	通过文件名，获取Document完整路径，如果不存在返回为nil
 *
 *	@param 	fileName 	文件名
 *
 *	@return	返回完整路径
 */
+ (NSString*)documentPath:(NSString*)fileName

{
	if(fileName == nil)
		return nil;
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString* documentsDirectory = [paths objectAtIndex: 0];
	NSString* documentsPath = [documentsDirectory stringByAppendingPathComponent: fileName];
	return documentsPath;
}

/**
 *	@brief	删除Document文件
 *
 *	@param 	fileName 	文件名
 *
 *	@return	是否成功删除
 */
+ (BOOL)deleteDocumentFile:(NSString*)fileName

{   
    BOOL del = NO;
	if(fileName == nil)
		return del;
	NSString* documentsPath = [self documentPath:fileName];
	if( [[NSFileManager defaultManager] fileExistsAtPath: documentsPath])
	{
		
		del = [[NSFileManager defaultManager] removeItemAtPath: documentsPath error:nil];
	}
	return del;
}

/**
 *	@brief	判断Cache是否存在
 *
 *	@param 	fileName 	文件名
 *
 *	@return	是否存在文件
 */
+ (BOOL)fileExistInCachesPath:(NSString*)fileName

{
	if(fileName == nil)
		return NO;
	NSString* cachesPath = [self cachesFilePath:fileName];
	return [[NSFileManager defaultManager] fileExistsAtPath: cachesPath];
}

/**
 *	@brief	通过文件名返回完整的Caches目录下的路径，如果不存在该路径返回nil
 *
 *	@param 	fileName 	文件名
 *
 *	@return	返回Caches完整路径
 */
+ (NSString* )cachesFilePath:(NSString*)fileName
{
	if(fileName == nil)
		return nil;
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString* cachesdirectory = [paths objectAtIndex: 0];
	NSString* cachesPath = [cachesdirectory stringByAppendingPathComponent:fileName];
	return cachesPath;
}

/**
 *	@brief	删除Caches文件
 *
 *	@param 	fileName 	文件名
 *
 *	@return	删除是否成功
 */
+ (BOOL)deleteCachesFile:(NSString*)fileName

{
    BOOL del = NO;
	if(fileName == nil)
		return del;
	NSString* cachesPath = [self cachesFilePath:fileName];
	if( [[NSFileManager defaultManager] fileExistsAtPath: cachesPath])
	{
		del = [[NSFileManager defaultManager] removeItemAtPath: cachesPath error:nil];
	}
	return del;
}

/**
 *	@brief	格式化时间为字符串
 *
 *	@param 	date 	NSDate系统时间类型
 *
 *	@return	返回默认格式yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)encodeTime:(NSDate *)date

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [formatter stringFromDate:date];
    }
    @catch (NSException *exception) {
        return @"";
    }
    @finally {
    }
}

/**
 *	@brief	字符串格式化为时间格式
 *
 *	@param 	dateString 	默认格式yyyy-MM-dd HH:mm:ss
 *
 *	@return	返回时间格式
 */
+ (NSDate *)dencodeTime:(NSString *)dateString

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [formatter dateFromString:dateString];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
    }
    
}

+ (NSString *)convertDateFromCST:(NSString *)_date
{
    if (_date == nil) {
        return nil;
    }
    //return nil;
    NSLog(@"_date==%@",_date);
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"EEE MMM dd HH:mm:ss 'CST' yyyy"];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];

    
    NSDate *formatterDate = [inputFormatter dateFromString:_date];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    NSLog(@"newDateString==%@",newDateString);
    return newDateString;
}

/**
 *	@brief	离现在时间相差时间
 *
 *	@param 	date 	时间格式
 *
 *	@return	返回字符串
 */
+ (NSString *)timeSinceNow:(NSDate *)date

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeInterval interval = 0 - [date timeIntervalSinceNow];
        
        if (interval < 60) {
            // 几秒前
            return @"1分钟内";
        } else if (interval < (60 * 60)) {
            // 几分钟前
            return [NSString stringWithFormat:@"%u分钟前", (int)(interval / 60)];
        } else if (interval < (24 * 60 * 60)) {
            // 几小时前
            return [NSString stringWithFormat:@"%u小时前", (int)(interval / 60 / 60)];
        } else if (interval < (2 * 24 * 60 * 60)) {
            // 昨天
            [formatter setDateFormat:@"昨天"];
            return [formatter stringFromDate:date];
        } else if (interval < (3 * 24 * 60 * 60)) {
            // 前天
            [formatter setDateFormat:@"前天"];
            return [formatter stringFromDate:date];
            //    } else if (interval < (7 * 24 * 60 * 60)) {
            // 一星期内
        } else {
            // 具体时间
            NSInteger days = interval / (24 * 60 * 60);
            
            return [NSString stringWithFormat:@"%ld天前",(long)days];
        }
        
        
    }
    @catch (NSException *exception) {
        return @"";
    }
    @finally {
    }
}

+ (NSTimeInterval )timeSinceNowNSTimeInterval:(NSDate *)date
{
    @try {
        NSTimeInterval interval = 0 - [date timeIntervalSinceNow];
        return interval;
    }
    @catch (NSException *exception) {
        return 0;
    }
    @finally {
    }
}

/**
 *	@brief	把秒转化为时间字符串显示，播放器常用
 *
 *	@param 	durartion 	传入参数
 *
 *	@return	播放器播放进度时间，比如
 */
+ (NSString *)changeSecondsToString:(CGFloat)durartion
{
    int hh = durartion/(60 * 60);
    int mm = hh > 0 ? (durartion - 60*60)/60 : durartion/60;
    int ss = (int)durartion%60;
    NSString *hhStr,*mmStr,*ssStr;
    if (hh == 0) {
        hhStr = @"00";
    }else if (hh > 0 && hh < 10) {
        hhStr = [NSString stringWithFormat:@"0%d",hh];
    }else {
        hhStr = [NSString stringWithFormat:@"%d",hh];
    }
    if (mm == 0) {
        mmStr = @"00";
    }else if (mm > 0 && mm < 10) {
        mmStr = [NSString stringWithFormat:@"0%d",mm];
    }else {
        mmStr = [NSString stringWithFormat:@"%d",mm];
    }
    if (ss == 0) {
        ssStr = @"00";
    }else if (ss > 0 && ss < 10) {
        ssStr = [NSString stringWithFormat:@"0%d",ss];
    }else {
        ssStr = [NSString stringWithFormat:@"%d",ss];
    }
    return [NSString stringWithFormat:@"%@:%@:%@",hhStr,mmStr,ssStr];
}


/**
 *	@brief	格式化时间为字符串
 *
 *	@param 	date 	时间
 *	@param 	format 	格式化字符串
 *
 *	@return	返回时间字符串
 */
+ (NSString *)encodeTime:(NSDate *)date format:(NSString *)format

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        return [formatter stringFromDate:date];
    }
    @catch (NSException *exception) {
        return @"";
    }
    @finally {
    }
    
}

/**
 *	@brief  格式化成时间格式
 *
 *	@param 	dateString 	时间字符串
 *	@param 	format 	格式化字符串
 *
 *	@return	返回时间格式
 */
+ (NSDate *)dencodeTime:(NSString *)dateString format:(NSString *)format

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        return [formatter dateFromString:dateString];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
    }
    
}

/**
 *	@brief	跳转到APPSTORE软件下载页面
 *
 *	@param 	appid 	APPID
 */
+ (void)goToAppStoreHomePage:(NSInteger)appid

{
    NSString *str = [NSString stringWithFormat:@"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%ld", (long)appid];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]]; 
}

/**
 *	@brief	跳转到APPSTORE软件评论页面
 *
 *	@param 	appid 	APPID
 */
+ (void)goToAppStoreCommentPage:(NSInteger)appid

{
    NSString *str = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%ld", (long)appid ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]]; 
}

/**
 *	@brief	发短信
 *
 *	@param 	phoneNumber 	手机号码
 */
+ (void)goToSmsPage:(NSString*)phoneNumber

{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",phoneNumber]]];
}

//打电话
+ (void)goToTelephone:(NSString *)phoneNumber{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
    
}


/**
 *	@brief	打开网页
 *
 *	@param 	url 	网页地址
 */
+ (void)openBrowse:(NSString*)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

/**
 *	@brief	发送邮件
 *
 *	@param 	email 	email地址
 */
+ (void)openEmail:(NSString*)email;

{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@",email]]];
}

+ (CGFloat)freeDiskSpace
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachePath = [paths objectAtIndex:0];
    NSDictionary *fileAttr = [[NSFileManager defaultManager] attributesOfFileSystemForPath:cachePath error:nil];
    float freeSpace = [[fileAttr objectForKey:NSFileSystemFreeSize] floatValue];
    return freeSpace;

}


/**
 *	@brief	通过字节获取文件大小
 *
 *	@param 	number 	字节数
 *
 *	@return	返回大小
 */
+ (NSString*)getSize:(NSNumber*)number

{
    NSInteger size=[number intValue];
    if(size<1024)
        return [NSString stringWithFormat:@"%ldB", (long)size];
    else
    {
         NSInteger size1=size/1024;
        if(size1<1024)
        {
            return [NSString stringWithFormat:@"%ld.%ldKB", (long)size1,(long)(size-size1*1024)/10];
        }
        else
        {
            NSInteger size2=size1/1024;
            if(size2<1024)
                return [NSString stringWithFormat:@"%ld.%ldMB", (long)size2,(long)(size1-size2*1024)/10];
        }
    }
    return nil;
}

/**
 *	@brief	获取随即数
 *
 *	@param 	min 	最小数值
 *	@param 	max 	最大数值
 *
 *	@return	返回数值
 */
+ (NSInteger)getRandomNumber:(NSInteger)min maxNumber:(NSInteger)max
{
    NSInteger value=0;
    if(min>0)
        value= (arc4random() % (max-min+1)) + min;
    else
        value= arc4random() % max;
    return value;
}

/**
 *	@brief	获取颜色
 *
 *	@param 	stringToConvert 	取色数值
 *
 *	@return	返回颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert withAlpha:(CGFloat)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
+ (NSString *) changeUIColorToRGB:(UIColor *)color
{
    const CGFloat *cs=CGColorGetComponents(color.CGColor);
    NSString *r = [NSString stringWithFormat:@"%@",[self ToHex:cs[0]*255]];
    NSString *g = [NSString stringWithFormat:@"%@",[self  ToHex:cs[1]*255]];
    NSString *b = [NSString stringWithFormat:@"%@",[self  ToHex:cs[2]*255]];
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
}

//十进制转十六进制
+(NSString *)ToHex:(int)tmpid
{
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
            
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
            
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}

/**
 *	@brief	UILabel高度
 *
 *	@param 	str 	文字
 *	@param 	front 	字体
 *	@param 	frontwidth 	UILabel宽度
 *
 *	@return	返回高度
 */
+ (CGFloat)returnHeightFloat:(NSString *)str frontSize:(UIFont*)front frontWidth:(CGFloat)frontwidth
{
    CGSize asize = CGSizeMake(frontwidth,5000);
    
    NSDictionary *attribute = @{NSFontAttributeName:front};
    CGSize labelsize = [str boundingRectWithSize:asize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return  labelsize.height;
}

//输入文字、字体大小、最大长度限制 返回label长度
+(CGFloat)returnWidthWithLabel:(NSString *)string frontSize:(CGFloat )frontSize maxSize:(CGSize)maxSize{
    
    NSDictionary* attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:frontSize]};
    CGSize labSize = [string boundingRectWithSize: maxSize
                                          options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                       attributes:attributes
                                          context:nil].size;
    
    return labSize.width;
}

/**
 *	@brief	检查是否可用网络
 *
 *	@return	返回是否可用
 */
+ (BOOL)checkConnectNet

{
    struct  sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *) &zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) 
    {
        return NO;
    } 
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES:NO;
}

/**
 *	@brief	推送状态栏消息
 *
 *	@param 	message 	消息
 *	@param 	time 	延迟时间
 */
+ (void)addStatusMessage:(NSString*)message afterTime:(CGFloat)time;
{
    
    [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelStatusBar];
    [[UIApplication sharedApplication].keyWindow setFrame:CGRectMake(0, 20, 320, 460)];
    for(UIView* view in [[UIApplication sharedApplication].keyWindow  subviews])
    {
        if(view.tag==1000)
        {
            [view removeFromSuperview];
        }
    }
    UILabel *signLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
    [signLabel setBackgroundColor:[UIColor blackColor]];
    [signLabel setText:message];
    [signLabel setTextColor:[UIColor whiteColor]];
    [signLabel setTextAlignment:1];
    [signLabel setFont:[UIFont systemFontOfSize:13]];
    [signLabel setTag:1000];
    [[UIApplication sharedApplication].keyWindow addSubview:signLabel];
    
    // Label进入动画
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromBottom;
    [[signLabel layer] addAnimation:animation forKey:@"animation"];
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:time 
                                     target:self 
                                   selector:@selector(removeStatusMessage) 
                                   userInfo:nil 
                                    repeats:NO];
}

/**
 *	@brief	消除状态栏消息
 */
+ (void)removeStatusMessage

{
    for(UIView* view in [[UIApplication sharedApplication].keyWindow  subviews])
    {
        if(view.tag==1000)
        {
            [view removeFromSuperview];
        }
    }
}


+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}


/**
 * @brief 图片压缩
 *  UIGraphicsGetImageFromCurrentImageContext函数完成图片存储大小的压缩
 * Detailed
 * @param[in] 源图片；指定的压缩size
 * @param[out] N/A
 * @return 压缩后的图片
 * @note
 */
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

+ (void)shakeAnimationForView:(UIView *)shakeView
{
    // 获取到当前的View
    CALayer *viewLayer = shakeView.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 15, position.y);
    CGPoint y = CGPointMake(position.x - 15, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:0.1];
    // 设置次数
    [animation setRepeatCount:3];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
}

+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL) validatePassword:(NSString *)passWord
{
    //6-16位数字或字母组成
    NSString *regex = @"^[0-9A-Za-z]{6,16}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:passWord];
}

+ (BOOL)validatePhoneNum:(NSString *)phoneNum
{
 
    NSString *regex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phoneNum];
}
+ (void)initLocalNotifictionWithDate:(NSDate *)date userInfo:(NSDictionary *)userInfo message:(NSString *)message
{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil)
    {
        notification.fireDate = date;
        notification.userInfo = userInfo;
        //使用本地时区
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.alertBody= [NSString stringWithFormat:@"%@时间到了",message];
        //通知提示音 使用默认的
        notification.applicationIconBadgeNumber=1;
        notification.soundName= UILocalNotificationDefaultSoundName;
        notification.alertAction = [NSString stringWithFormat:@"%@时间到了",message];
        // 假如你的通知不会在还没到时间的时候手动取消 那下面的两行代码你可以不用写了。
        //启动这个通知
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
        //这句真的特别特别重要。如果不加这一句，通知到时间了，发现顶部通知栏提示的地方有了，然后你通过通知栏进去，然后你发现通知栏里边还有这个提示
        //除非你手动清除，这当然不是我们希望的。加上这一句就好了。网上很多代码都没有，就比较郁闷了。
    }
}

+ (void)deleteSingleNotificationWithRemarkId:(NSInteger)remarkId
{
    NSArray *notArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in notArray)
    {
        if ([[notification.userInfo objectForKey:@"remarkId"] integerValue] == remarkId)
        {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
}

+ (NSUInteger) lenghtWithString:(NSString *)string
{
    NSUInteger len = string.length;
    // 汉字字符集
    NSString * pattern  = @"[\u4e00-\u9fa5]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    // 计算中文字符的个数
    NSInteger numMatch = [regex numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    
    return len + numMatch;
}

//设置图片方向
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)cropImageWithRect:(CGRect)newImageSize image:(UIImage *)image
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, newImageSize);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return smallImage;
}

+ (UIImage *)changeViewToImage:(UIView *)currentView compress:(CGFloat)compress
{
    UIGraphicsBeginImageContext(currentView.bounds.size);
    [currentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (compress < 1)
    {
        viewImage = [self imageWithImage:viewImage scaledToSize:CGSizeMake(viewImage.size.width * compress, viewImage.size.height * compress)];
    }
    return viewImage;
}

//完全复制一项
+ (id)totalCopyOneItem:(id)oldItem
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:oldItem];
    id newElementArray = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
    return newElementArray;
}

+ (void)copyStringWithString:(NSString *)needCopyStr
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:needCopyStr];
}

+ (void)openSafariWithUrl:(NSString *)urlStr
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}


//数组排序（正序）
+ (void)sortArrayWithSortArray:(NSMutableArray *)arry
{
    [arry sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2){
        NSInteger area1 = [obj1 integerValue];
        NSInteger area2 = [obj2 integerValue];
        if (area1 > area2)
            return NSOrderedAscending;
        else
            return NSOrderedDescending;
    }];
}

//字典排序（正序）这是按照values的排序
+ (NSArray *)sortDicWithSortDictionary:(NSMutableDictionary *)dic
{
    NSArray *keys = [dic keysSortedByValueUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2){
        NSInteger area1 = [obj1 integerValue];
        NSInteger area2 = [obj2 integerValue];
        if (area1 > area2)
            return NSOrderedAscending;
        else
            return NSOrderedDescending;
    }];
    return keys;
}

/** 自定义的字体 */
+ (UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size
{
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    if (fontRef) {
        CTFontManagerUnregisterGraphicsFont(fontRef,nil);

    }
    CTFontManagerRegisterGraphicsFont(fontRef, nil);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    return font;

}


+ (id)getUserPreferenceObjectForKey:(NSString *)key {
    NSString *keyWithUid = [key stringByAppendingString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]];
    return [[NSUserDefaults standardUserDefaults] objectForKey:keyWithUid];
}

+ (void)saveUserPreferenceObject:(NSObject *)object forKey:(NSString *)key {
    NSString *keyWithUid = [key stringByAppendingString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]];
    NSUserDefaults *preference = [NSUserDefaults standardUserDefaults];
    [preference setObject:object forKey:keyWithUid];
    [preference synchronize];
}

@end
