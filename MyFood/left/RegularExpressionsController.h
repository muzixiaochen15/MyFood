//
//  RegularExpressionsController.h
//  MyFood
//
//  Created by qunlee on 16/11/8.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD/MBProgressHUD.h"

typedef NS_ENUM(NSInteger, RegularType) {
    //有数字、26个英文字母组成的字符串
    RegularTypeNumberAndCharacter = 1,
    //长度为8-10的用户密码（以字母开头、数字、下划线）
    RegularTypeFixedLength,
    //验证输入只能是汉字
    RegularTypeHanZi,
    //电子邮箱验证
    RegularTypeEmail,
    //URL地址验证
    RegularTypeUrl,
    //电话号码的验证
    RegularTypePhoneNumber,
    //简单的身份证号验证
    RegularTypeIDCardNo
};

@interface RegularExpressionsController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *inputTextField;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *verififyArrays;

@property (nonatomic, assign) RegularType tempType;

@property (nonatomic, strong) MBProgressHUD *hub;

@property (nonatomic, strong) UITextField *regularExpField;
@end
