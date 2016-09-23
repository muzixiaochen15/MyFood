//
//  EQXRequest.h
//  MyFood
//
//  Created by qunlee on 16/9/18.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UpdateDataBlock)();

/** 网络类型 */
typedef NS_ENUM(NSUInteger, RequestType) {
    kRequestTypeGet,
    kRequestTypePost
};

@interface EQXRequest : NSObject

@property (copy, nonatomic) UpdateDataBlock updateDataBlock;

/** http请求 */
- (void)requestWithUrl:(NSString *)url
       withRequestType:(RequestType)type
        withParameters:(NSDictionary *)parameters
       withFinishBlcok:(void (^)(NSDictionary *jsonDic))finishBlock;
/** 下载 */
- (void)downLoadTaskRequestWithUrl:(NSString *)urlString;
/** 上传 */
- (void)createUploadTaskRequestWithUrl:(NSString *)urlString
                          withFilePath:(NSString *)filePathStr;
/** 上传 */
- (void)createUploadTaskForMultipartRequestWithUrl:(NSString *)urlString
                                        withMethod:(NSString *)method
                                      withFileName:(NSString *)fileName;
/** 创建数据任务请求 */
- (void)createDataTaskRequestWithUrl:(NSString *)urlString;

@end
