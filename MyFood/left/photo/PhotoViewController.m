//
//  PhotoViewController.m
//  MyFood
//
//  Created by qunlee on 16/8/19.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "PhotoViewController.h"
#import "EQXColor.h"
#import "PhotosStore/YPPhotoStore.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _maxSelectedPhotos = 9;
    self.viewControllers = @[[[PhotoGroupViewController alloc]init]];
    PhotoGroupViewController *rootVC = [self.viewControllers firstObject];
    [self.navigationBar setBarTintColor:[EQXColor colorWithHexString:@"#212636"]];
    [self.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationBar setTranslucent:NO];
    rootVC.maxNumberOfSelectImages = [NSNumber numberWithUnsignedInteger:_maxSelectedPhotos];
    __weak typeof (self) weakSelf = self;
    rootVC.photosCallBack = ^(NSArray <PHAsset *> *assets, NSArray <NSNumber *> *status){
        if (_assetCallBack) {
            _assetCallBack(assets, status);
        }
        if (_imageCallBack) {
            [YPPhotoStoreHandleClass imagesWithAssets:assets status:status Size:_imageSize complete:^(NSArray<UIImage *> * _Nonnull images) {
                _imageCallBack(images);
                [weakSelf dismissViewControllerAnimated:true completion:nil];
            }];
        }else{
            [weakSelf dismissViewControllerAnimated:true completion:nil];
        }
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
