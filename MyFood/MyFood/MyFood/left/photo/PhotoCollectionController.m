//
//  PhotoCollectionController.m
//  MyFood
//
//  Created by qunlee on 16/8/19.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "PhotoCollectionController.h"
#import "PhotoViewController.h"
#import "EQXColor.h"
#import "YPPhotosCell.h"
#import "PHObject+SupportCategory.h"
#import "PhotoViewController.h"
#import "PhotosStore/YPPhotoStore.h"

@interface PhotoCollectionController ()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>{
    CGSize assetSize;
    NSArray <UIImage *> *assets;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation PhotoCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBarButtonItem];
    [self addSubLabel];
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    CGFloat sizeHeight = (CGRectGetWidth(self.view.frame) - 3)/3.0f;
    assetSize = CGSizeMake(sizeHeight, sizeHeight);
    [self.view addSubview:self.collectionView];
    
    YPPhotoStore *store = [YPPhotoStore new];
    [store checkGroupExist:@"new" result:^(BOOL isExist, PHAssetCollection * _Nullable collection) {
        if (isExist)
            NSLog(@"exist!");
        else
            NSLog(@"not exist!");
    }];
}
- (void)addSubLabel{
    UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.frame) - 40.0f, 40.0f)];
    subLabel.center = self.view.center;
    subLabel.backgroundColor = [UIColor clearColor];
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.textColor = [EQXColor colorWithHexString:@"#e8e8e8"];
    subLabel.text = @"相册中选取的图片，支持多选";
    [self.view addSubview:subLabel];
}
- (void)addNavBarButtonItem{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0.0f, 0.0f, 50.0f, 44.0f);
    [addButton setTitle:@"创建" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc]initWithCustomView:addButton];
    
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    photoButton.frame = CGRectMake(0.0f, 0.0f, 50.0f, 44.0f);
    [photoButton setTitle:@"相册" forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(photoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *photoItem = [[UIBarButtonItem alloc]initWithCustomView:photoButton];
    
    self.navigationItem.rightBarButtonItems = @[addBtnItem, photoItem];
}
- (void)addButtonClicked:(UIButton *)button{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"新建相册" message:@"留住美好的时刻！" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"新建相册名字";
    }];
    __weak typeof(alertController) weakAlert = alertController;
    //apple使用了block代替了delegate
    [alertController addAction:[UIAlertAction  actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获得textFiled
        UITextField * textField = weakAlert.textFields.firstObject;
        if (textField.text.length == 0) {
            return ;
        }
        //创建新的相册
        YPPhotoStore * photoStore = [YPPhotoStore new];
        
        [photoStore addCustomGroupWithTitle:textField.text completionHandler:^{
            ;
        } failture:^(NSString * _Nonnull error) {
            ;
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertController animated:true completion:nil];
}
- (void)photoButtonClicked:(UIButton *)button{
    PhotoViewController *photoVC = [[PhotoViewController alloc]init];
    __weak typeof(self) weakSelf = self;
    photoVC.imageSize = assetSize;
    photoVC.imageCallBack = ^(NSArray <UIImage *> * images){
        if (weakSelf) {
            assets = images;
            [weakSelf.collectionView reloadData];
        }
    };
    [self presentViewController:photoVC animated:YES completion:nil];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 5.0f);
        layout.itemSize = assetSize;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [EQXColor colorWithHexString:@"#f8f8f8"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        [_collectionView registerClass:[YPPhotosCell class] forCellWithReuseIdentifier:NSStringFromClass([YPPhotosCell class])];
    }
    return _collectionView;
}
#if 0
- (HintHouse *)hintHouse{
    if (!hintHouse) {
        hintHouse = [[HintHouse alloc]init];
        hintHouse.size = 99.0f;
        hintHouse.price = 1500.0f;
        hintHouse.location = LocationTypeNearMetro;
    }
    return hintHouse;
}
#endif
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YPPhotosCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YPPhotosCell class]) forIndexPath:indexPath];
    
#pragma photoViewController.photoImageSelectBlock 搭配imageSize 的用法
    cell.imageView.image = assets[indexPath.item];
    cell.chooseImageView.hidden = true;
    
#pragma photoViewController.photosDidSelectBlock用法，自己对资源进行裁剪
    /**********避免block中进行retain影响对象释放，造成内存泄露*********/
    //    __weak typeof(YPPhotosCell *)copy_cell = cell;
    //
    //    [((PHAsset *)[self.assets objectAtIndex:indexPath.item]) representationImageWithSize:_assetSize complete:^(UIImage * _Nullable image, PHAsset * _Nonnull asset) {
    //
    //        copy_cell.imageView.image = image;
    //        copy_cell.chooseImageView.hidden = true;
    //
    //    }];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return assetSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}

@end
