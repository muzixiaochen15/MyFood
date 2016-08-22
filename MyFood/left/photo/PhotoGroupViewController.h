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

typedef void (^PhotoAssetsEndSelectedCallBack) (NSArray <PHAsset *> *, NSArray <NSNumber *> *);

@interface PhotoGroupViewController : UITableViewController<YPPhotosControllerDelegate>
@property (nonatomic, strong) YPPhotoStore * photoStore;
@property (nonatomic, strong) NSArray<PHAssetCollection *> * groups;
@property (nonatomic, strong) NSNumber * maxNumberOfSelectImages;
@property (nullable, nonatomic, copy) PhotoAssetsEndSelectedCallBack photosCallBack;

@end
