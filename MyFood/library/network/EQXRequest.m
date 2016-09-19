//
//  EQXRequest.m
//  MyFood
//
//  Created by qunlee on 16/9/18.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "EQXRequest.h"
#import <AFNetworking/AFNetworking.h>

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
        //add request head code
    }
    return _manager;
}
- (void)requestWithUrl:(NSString *)url
       withRequestType:(RequestType)type
          withParameters:(NSDictionary *)parameters{
    switch (type) {
        case kRequestTypeGet:
        {
            [_manager GET:url
               parameters:parameters
                 progress:^(NSProgress * _Nonnull downloadProgress) {
                     
                 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                 }];
        }
            break;
        case kRequestTypePost:
        {
            [_manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
            break;
        default:
            break;
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
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configure];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            
        }else{
            
        }
    }];
    [dataTask resume];
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
