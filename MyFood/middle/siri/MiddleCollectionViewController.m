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

@interface MiddleCollectionViewController ()

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation MiddleCollectionViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"场景";
    [self configureViews];
}

- (void)configureViews{
    _items = @[@[@"juhe", [JuHeTableViewController class]]];
    [self.collectionView registerClass:[MiddleCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([MiddleCollectionCell class])];
//    [self.collectionView reloadData];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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
//        _collectionView.collectionViewLayout = layout;
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
    UIViewController *viewController = [self viewControllerForRowAtIndexPath:indexPath];
    viewController.title = [self titleForRowAtIndexPath:indexPath];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = 0.0f;
//    CGFloat cellHeight = 0.0f;
    cellWidth = (CGRectGetWidth([UIScreen mainScreen].bounds) - 4*3)/3;
//    cellHeight = cellWidth * (CGRectGetHeight([UIScreen mainScreen].bounds)/CGRectGetWidth([UIScreen mainScreen].bounds));
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
    [cell.textButton setTitle:_items[indexPath.row][0] forState:UIControlStateNormal];
    return cell;
}
- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[_items[indexPath.row]lastObject] new];
}
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_items[indexPath.row]firstObject];
}
@end
