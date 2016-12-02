//
//  PartAlphaViewController.m
//  MyFood
//
//  Created by qunlee on 16/12/1.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "PartAlphaViewController.h"
#import "EQXColor.h"
#import "PartAlphaView.h"

@interface PartAlphaViewController ()

@end

@implementation PartAlphaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"detail_bg_image.JPG"];
    [self.view addSubview:imageView];
    PartAlphaView *partView = [[PartAlphaView alloc]initWithFrame:self.view.bounds];
//    [partView.layer setBackgroundColor:(__bridge CGColorRef _Nullable)([UIColor colorWithPatternImage:[UIImage imageNamed:@"detail_bg_image.JPG"]])];
    partView.backgroundColor = [UIColor clearColor];
    partView.maskRect = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    [self.view addSubview:partView];
    
    UIView *bgImageView = [[UIView alloc]initWithFrame:CGRectMake(100.0f, 300.0f, 100.0f, 100.0f)];
    [bgImageView.layer setBackgroundColor:(__bridge CGColorRef _Nullable)([UIColor colorWithPatternImage:[UIImage imageNamed:@"icon"]])];
    [self.view addSubview:bgImageView];
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
