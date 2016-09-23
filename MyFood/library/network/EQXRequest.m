//
//  EQXRequest.m
//  MyFood
//
//  Created by qunlee on 16/9/18.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "EQXRequest.h"
#import <AFNetworking/AFNetworking.h>
#import "SNLoading.h"
#import <PINCache/PINCache.h>

@interface EQXRequest ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation EQXRequest

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html", nil];
        //add request head code
    }
    return _manager;
}

- (void)requestWithUrl:(NSString *)url
       withRequestType:(RequestType)type
        withParameters:(NSDictionary *)parameters
       withFinishBlcok:(void (^)(NSDictionary *jsonDic))finishBlock{
    __weak EQXRequest *weakSelf = self;
    switch (type) {
        case kRequestTypeGet:
        {
            [SNLoading showWithTitle:nil];
            [self.manager GET:url
               parameters:parameters
                 progress:^(NSProgress * _Nonnull downloadProgress) {
                 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     [SNLoading hideWithTitle:nil];
                     if (weakSelf) {
                         [weakSelf jsonDicParserWithDic:responseObject withUrlString:url withFinishBlock:finishBlock];
                     }
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     [SNLoading hideWithTitle:nil];
                     NSDictionary *jsonDic = @{@"code": [NSNumber numberWithInteger:error.code]};
                     if (weakSelf) {
                         [weakSelf jsonDicParserWithDic:jsonDic withUrlString:url withFinishBlock:finishBlock];
                     }
                 }];
        }
            break;
        case kRequestTypePost:
        {
            [self.manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (weakSelf) {
                    [weakSelf jsonDicParserWithDic:responseObject withUrlString:url withFinishBlock:finishBlock];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSDictionary *jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:error.code],@"code", nil];
                if (weakSelf) {
                    [weakSelf jsonDicParserWithDic:jsonDic withUrlString:url withFinishBlock:finishBlock];
                }
            }];
        }
            break;
        default:
            break;
    }
}
- (void)jsonDicParserWithDic:(NSDictionary *)jsonDic
               withUrlString:(NSString *)urlString
             withFinishBlock:(void (^)(NSDictionary *jsonDic))finishBlock{
    if (!jsonDic||![jsonDic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    //add exception code
    if (finishBlock) {
        finishBlock(jsonDic);
    }
}
- (void)downLoadTaskRequestWithUrl:(NSString *)urlString{
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configure];
    NSURL *url = [NSURL URLWithString:urlString];//http://example.com/download.zip
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *downTask = [manager downloadTaskWithRequest:request
                                                                  progress:nil
                                                               destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                                   NSURL *documentDirectory = [[NSFileManager defaultManager]URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                                                                   return [documentDirectory URLByAppendingPathComponent:[response suggestedFilename]];
                                                                  } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                                      NSLog(@"file download to %@", filePath);
                                                                  }];
    [downTask resume];
}
- (void)createUploadTaskRequestWithUrl:(NSString *)urlString
                          withFilePath:(NSString *)filePathStr{
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configure];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURL *filePath = [NSURL fileURLWithPath:filePathStr];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            
        }else{
            
        }
    }];
    [uploadTask resume];
}
- (void)createUploadTaskForMultipartRequestWithUrl:(NSString *)urlString
                                        withMethod:(NSString *)method
                                      withFileName:(NSString *)fileName{
    //method:@"POST"
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:method URLString:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:[NSURL URLWithString:urlString] name:@"file" fileName:fileName mimeType:@"image" error:nil];//file:文件相关 fileNmae:filename.jpeg
    } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //add progress code
        });
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            
        }else{
            
        }
    }];
    [uploadTask resume];
}
- (void)createDataTaskRequestWithUrl:(NSString *)urlString{
    [SNLoading showWithTitle:nil];
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configure];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak EQXRequest *weakSelf = self;
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            
        }else{
            if (weakSelf) {
                [weakSelf jsonToObjectWithDic:nil];
            }
            if (_updateDataBlock) {
                _updateDataBlock();
            }
        }
        [SNLoading hideWithTitle:nil];
    }];
    [dataTask resume];
}
- (void)jsonToObjectWithDic:(NSDictionary *)dic{
    if (dic) {
        
    }
}
- (void)setCookieWithJSESSIONID
{
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"cookieWithJSESSIONID"];
    if([cookiesdata length])
    {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies)
        {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
}

@end
