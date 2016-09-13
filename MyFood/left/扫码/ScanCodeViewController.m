//
//  ScanCodeViewController.m
//  MyFood
//
//  Created by qunlee on 16/9/2.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "ScanCodeViewController.h"
#import "EQXColor.h"

@implementation ScanCodeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    [self josephusCodeWithNum:41];
}
/** 约瑟夫问题 */
- (void)josephusCodeWithNum:(int)num{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0; i < num; i++) {
        NSDictionary *subDic = @{@"num": @(i + 1)};
        [array addObject:[subDic mutableCopy]];
    }
    static int cursor = 3;
    while ([array count] > 2) {
        NSLog(@"the num %d person was killed!", cursor);
        [array removeObjectAtIndex:(cursor - 1)];
        cursor += 2;
        if (cursor > [array count]) {
            cursor -= (int)[array count];
        }
    }
    for (NSDictionary *dict in array) {
        NSLog(@"live person num %@", dict[@"num"]);
    }
}
@end
