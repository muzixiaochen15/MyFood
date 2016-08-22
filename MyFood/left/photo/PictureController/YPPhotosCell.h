//
//  YPPhotosCell.h
//  YPPhotoDemo
//
//  Created by YueWen on 16/7/14.
//  Copyright © 2016年 YueWen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YPPhotosCell;

NS_ASSUME_NONNULL_BEGIN

typedef void(^YPPhotosCellOperationBlock)(YPPhotosCell * __nullable cell);

@interface YPPhotosCell : UICollectionViewCell

/// display backgroundImage
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

/// default hidden is true
@property (strong, nonatomic) IBOutlet UIView *messageView;

/// imageView in messageView to show the kind of asset
@property (strong, nonatomic) IBOutlet UIImageView *messageImageView;

/// label in messageVie to show the information
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

/// button in order to display the selected image
@property (strong, nonatomic) IBOutlet UIButton *chooseImageViewBtn __deprecated_msg("Use chooseImageView");

/// 负责显示选中的按钮
@property (strong, nonatomic) UIImageView * chooseImageView;

/// 负责响应点击事件的Control对象
@property (strong, nonatomic) UIControl * chooseControl;

//evoked when the chooseImageView clicked
@property (nullable, copy, nonatomic)YPPhotosCellOperationBlock imageSelectedBlock;
@property (nullable, copy, nonatomic)YPPhotosCellOperationBlock imageDeselectedBlock;



//simple method to set UI change, not evoked the block
- (void) cellDidSelect;
- (void) cellDidDeselect;


@end

NS_ASSUME_NONNULL_END
