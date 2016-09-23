//
//  MiddleCollectionViewController.m
//  MyFood
//
//  Created by qunlee on 16/9/14.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "MiddleCollectionViewController.h"
#import "JuHeTableViewController.h"
#import "MiddleCollectionCell.h"
#import "PureLayout/PureLayout.h"
#import "IOSReflectionTabviewController.h"
#import "EQXRequest.h"
#import "MFConstClass.h"
#import "FunnyTypeItem.h"
#import <PINCache/PINCache.h>

@interface MiddleCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) EQXRequest *request;


@end

@implementation MiddleCollectionViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"场景";
    _items = [[NSMutableArray alloc]init];
    [self getRequest];
}
- (void)getRequest{
    NSString *reqUrl = [NSString stringWithFormat:@"%@%@?key=%@", JuHeIP, JuHeFunnyType, JuHeFunnyAppKey];
    __weak MiddleCollectionViewController *weakSelf = self;
    [[PINCache sharedCache]objectForKey:reqUrl block:^(PINCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
        if (object&&[object isKindOfClass:[NSDictionary class]]) {
            if (weakSelf) {
                [weakSelf parseJsonDic:object withUrl:reqUrl];
            }
            return;
        }
        if (weakSelf) {
            [weakSelf.request requestWithUrl:reqUrl withRequestType:kRequestTypeGet withParameters:nil withFinishBlcok:^(NSDictionary *jsonDic) {
                if (weakSelf) {
                    [weakSelf parseJsonDic:jsonDic withUrl:reqUrl];
                }
            }];
        }
    }];
}
- (void)parseJsonDic:(NSDictionary *)jsonDic withUrl:(NSString *)url{
    if (jsonDic&&[jsonDic isKindOfClass:[NSDictionary class]]) {
        ///转化
        [[PINCache sharedCache]setObject:jsonDic forKey:url];
    }
    if (jsonDic[@"result"][@"data"] > 0) {
        NSDictionary *dic = jsonDic[@"result"][@"data"][0];
        NSArray *typeArray = dic.allKeys;
        for (NSString *num in typeArray) {
            FunnyTypeItem *item = [[FunnyTypeItem alloc]init];
            item.id = num;
            item.title = dic[num];
            NSArray *temArray = @[item, [JuHeTableViewController class]];
            [_items addObject:temArray];

        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self configureViews];
    });
}
- (EQXRequest *)request{
    if (!_request) {
        _request = [[EQXRequest alloc]init];
    }
    return _request;
}
- (void)configureViews{
    [self.collectionView registerClass:[MiddleCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([MiddleCollectionCell class])];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(64.0f, 46.0f);
        layout.minimumLineSpacing = 1.0f;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = NO;
        _collectionView.allowsSelection = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_collectionView];
        [_collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    }
    return _collectionView;
}
#pragma mark - UICollectionViewDelegate、UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_items count];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JuHeTableViewController *viewController = [self viewControllerForRowAtIndexPath:indexPath];
    viewController.title = [self titleForRowAtIndexPath:indexPath].title;
    viewController.listType = [self titleForRowAtIndexPath:indexPath].id;
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = 0.0f;
    cellWidth = (CGRectGetWidth([UIScreen mainScreen].bounds) - 4*3)/3;
    return CGSizeMake(cellWidth, cellWidth);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0f;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MiddleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MiddleCollectionCell class]) forIndexPath:indexPath];
    FunnyTypeItem *item = _items[indexPath.row][0];
    [cell.textButton setTitle:item.title forState:UIControlStateNormal];
    return cell;
}
- (JuHeTableViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[_items[indexPath.row]lastObject] new];
}
- (FunnyTypeItem *)titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_items[indexPath.row]firstObject];
}
@end
