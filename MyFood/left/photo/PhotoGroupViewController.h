//
//  PhotoGroupViewController.h
//  MyFood
//
//  Created by qunlee on 16/8/19.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/PHAsset.h>
#import "YPPhotosController.h"
#import "PhotosStore/YPPhotoStore.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^PhotoAssetsEndSelectedCallBack) (NSArray <PHAsset *> * _Nullable, NSArray <NSNumber *> * _Nullable);

@interface PhotoGroupViewController : UITableViewController<YPPhotosControllerDelegate>
@property (nonatomic, strong, nonnull) YPPhotoStore * photoStore;
@property (nonatomic, strong, nonnull) NSArray<PHAssetCollection *> * groups;
@property (nonatomic, strong) NSNumber * maxNumberOfSelectImages;
@property (nullable, nonatomic, copy) PhotoAssetsEndSelectedCallBack photosCallBack;

@end
NS_ASSUME_NONNULL_END