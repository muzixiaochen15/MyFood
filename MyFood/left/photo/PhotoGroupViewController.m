//
//  PhotoGroupViewController.m
//  MyFood
//
//  Created by qunlee on 16/8/19.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "PhotoGroupViewController.h"
#import "YPPhotoGroupCell.h"
#import "support/PHObject+SupportCategory.h"

@interface PhotoGroupViewController ()

@end

@implementation PhotoGroupViewController
- (void)dealloc{
    self.groups = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoStore = [[YPPhotoStore alloc]init];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.tableView registerClass:[YPPhotoGroupCell class] forCellReuseIdentifier:NSStringFromClass([YPPhotoGroupCell class])];
    
    //Navigation
    self.navigationItem.title = @"相册";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancle" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemDidTap)];
    
    __weak typeof(self)copy_self = self;
    
    //获取默认的相片组
    [self.photoStore fetchDefaultAllPhotosGroup:^(NSArray<PHAssetCollection *> * _Nonnull groups , PHFetchResult * _Nonnull fetchResult){
        copy_self.groups = groups;
        [copy_self.tableView reloadData];
        [copy_self pushPhotosViewController:[NSIndexPath indexPathForRow:0 inSection:0] Animate:false];
        
    }];
}
- (void)rightBarButtonItemDidTap{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPPhotoGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YPPhotoGroupCell class]) forIndexPath:indexPath];
    __weak typeof (cell) weakCell = cell;
    PHAssetCollection *collection = _groups[indexPath.row];
    [collection representationImageWithSize:CGSizeMake(60.0f, 60.0f) complete:^(NSString * _Nonnull title, NSUInteger estimatedCount, UIImage * _Nullable image) {
        weakCell.titleLabel.text = [NSString stringWithFormat:@"%@(%@)",title, @(estimatedCount)];
        weakCell.imageView.image = image;
    }];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self pushPhotosViewController:indexPath Animate:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}
#pragma mark - <YPPhotosControllerDelegate>
-(void)photosController:(YPPhotosController *)viewController photosSelected:(nonnull NSArray<PHAsset *> *)assets Status:(nonnull NSArray<NSNumber *> *)status
{
    if (_photosCallBack) {
        _photosCallBack(assets,status);
    }
}

-(void)photosControllerShouldBack:(YPPhotosController *)viewController
{
    [self dismissViewControllerAnimated:true completion:^{}];
}
#pragma mark - Navigation
- (void)pushPhotosViewController:(NSIndexPath *)indexPath Animate:(BOOL)animate{
    YPPhotosController *vc = [[YPPhotosController alloc]init];
    //传递组对象
    vc.assets = [self.photoStore fetchPhotos:self.groups[indexPath.row]];
    vc.itemTitle= self.groups[indexPath.row].localizedTitle;
    vc.maxNumberOfSelectImages = self.maxNumberOfSelectImages;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
