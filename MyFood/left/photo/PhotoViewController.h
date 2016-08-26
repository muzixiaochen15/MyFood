//
//  PhotoViewController.h
//  MyFood
//
//  Created by qunlee on 16/8/19.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/PHAsset.h>
#import "PhotoGroupViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^PhotosEndSelectedCallBack) (NSArray <UIImage *>   *_Nullable );

@interface PhotoViewController : UINavigationController
@property (nonatomic, assign) NSUInteger maxSelectedPhotos;
@property (nonatomic, copy, nullable) PhotoAssetsEndSelectedCallBack assetCallBack;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, copy, nullable) PhotosEndSelectedCallBack imageCallBack;
//test
@property (nonatomic, strong) NSString *string;

@end
NS_ASSUME_NONNULL_END