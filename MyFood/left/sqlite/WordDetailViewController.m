//
//  WordDetailViewController.m
//  MyFood
//
//  Created by qunlee on 16/10/8.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "WordDetailViewController.h"

@interface WordDetailViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textHeightConstraints;

@end

@implementation WordDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _wordNameLabel.text = _wordName;
    [_wordDetailLabel setContentMode:UIViewContentModeTopLeft];
    [self setDetailLabelWithContent:_wordDetail];
}
- (void)setDetailLabelWithContent:(NSString *)content{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.minimumLineHeight = 20.0f;
    paragraph.maximumLineHeight = 20.0f;
    paragraph.lineSpacing = 10.0f;
    NSDictionary *attribute = @{NSParagraphStyleAttributeName: paragraph, NSFontAttributeName: [UIFont fontWithName:@"FZY3K--GB1-0" size:20.0f]};
    CGRect rect = [content boundingRectWithSize:CGSizeMake(Screen_Width - 50.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    _textHeightConstraints.constant = rect.size.height + 5.0f;
    NSAttributedString *attr = [[NSAttributedString alloc]initWithString:content attributes:attribute];
    _wordDetailLabel.attributedText = attr;
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
