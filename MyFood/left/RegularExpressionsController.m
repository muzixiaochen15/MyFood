//
//  RegularExpressionsController.m
//  MyFood
//
//  Created by qunlee on 16/11/8.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "RegularExpressionsController.h"
#import "EQXColor.h"
#import "PureLayout/PureLayout.h"
#import "CollectionCell.h"
#import "MBProgressHUD/MBProgressHUD.h"

@implementation RegularExpressionsController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"";
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    _verififyArrays = @[@"数字、26个英文字母组成的字符串", @"长度为8-10的用户密码（以字母开头、数字、下划线）", @"验证输入只能是汉字", @"电子邮箱验证",  @"URL地址验证", @"电话号码的验证", @"简单的身份证号验证"];
    [self addConfigureViews];
}
- (void)addConfigureViews{
    _inputTextField = [UITextField newAutoLayoutView];
    _inputTextField.placeholder = @"请输入校验内容";
    _inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    _inputTextField.backgroundColor = [UIColor clearColor];
    _inputTextField.textAlignment = NSTextAlignmentLeft;
    _inputTextField.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:_inputTextField];
    [_inputTextField autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20.0f, 20.0f, 20.0f, 20.0f) excludingEdge:ALEdgeBottom];
    [_inputTextField autoSetDimension:ALDimensionHeight toSize:30.0f];

    UIButton *verifyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    verifyButton.backgroundColor = [EQXColor colorWithHexString:@"#56c6ff"];
    [verifyButton setTitle:@"校验" forState:UIControlStateNormal];
    [verifyButton addTarget:self action:@selector(verifyString:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:verifyButton];
    [verifyButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(60.0f, 20.0f, 20.0f, 20.0F) excludingEdge:ALEdgeBottom];
    [verifyButton autoSetDimension:ALDimensionHeight toSize:40.0f];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 1.0f;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((Screen_Width - 20.0f)/3.0f, (Screen_Width- 20.0f)/3.0f);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, Screen_Width, Screen_Height) collectionViewLayout:layout];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    [self.view addSubview:_collectionView];
    [_collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(115.0f, 0.0f, 0.0f, 0.0f)];
}
- (void)verifyString:(UIButton *)button{
    [self selectRegularType:_tempType];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _verififyArrays.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    [cell.btn setTitle:[_verififyArrays objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _tempType = indexPath.row + 1;
}
- (BOOL)selectRegularType:(RegularType)type{
    NSString *pattern = nil;
    switch (type) {
        case RegularTypeUrl:
        {
            pattern = @"^http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
        }
            break;
        case RegularTypeEmail:
        {
            pattern = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
        }
            break;
        case RegularTypeHanZi:
        {
            pattern = @"^[\u4e00-\u9fa5]{0,}$";
        }
            break;
        case RegularTypeIDCardNo:
        {
            pattern = @"\\d{15}|\\d{18}$";
        }
            break;
        case RegularTypeFixedLength:
        {
            pattern = @"^[a-zA-Z]\\w{7,10}$";
        }
            break;
        case RegularTypePhoneNumber:
        {
            pattern = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
        }
            break;
        case RegularTypeNumberAndCharacter:
        {
            pattern = @"^[A-Za-z0-9]+$";
        }
            break;
        default:
            break;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isValid = [predicate evaluateWithObject:_inputTextField.text];
    if (!isValid) {
        NSLog(@"输入有误");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"输入有误,请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"输入正确" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        [alert addAction: [UIAlertAction actionWithTitle:@"知道" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

        }]];
    }
    return isValid;
}
@end
