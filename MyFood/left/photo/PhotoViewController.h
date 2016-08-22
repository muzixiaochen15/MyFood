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

typedef void (^PhotosEndSelectedCallBack) (NSArray <UIImage *> *);

@interface PhotoViewController : UINavigationController
@property (nonatomic, assign) NSUInteger maxSelectedPhotos;
@property (nonatomic, copy, nullable) PhotoAssetsEndSelectedCallBack assetCallBack;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, copy, nullable) PhotosEndSelectedCallBack imageCallBack;

@end
