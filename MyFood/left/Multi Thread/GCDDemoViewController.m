//
//  GCDDemoViewController.m
//  MyFood
//
//  Created by qunlee on 16/12/6.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "GCDDemoViewController.h"
#import "EQXColor.h"
#import <PureLayout/PureLayout.h>

@interface GCDDemoViewController ()

@end

@implementation GCDDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *testImageView = [UIImageView newAutoLayoutView];
    self.view.backgroundColor = [EQXColor colorWithHexString:@"#f8f8f8"];
    testImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:testImageView];
    [testImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(50.0f, 50.0f, 50.0f, 50.0f)];
    /*
     dispatch_get_global_queue(,);得到队列
     dispatch_get_main_queue() 获得串行队列
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://avatar.csdn.net/2/C/D/1_totogo2010.jpg"];
        NSData *data = [[NSData alloc]initWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        if (data != nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                testImageView.image = image;
            });
        }
    });
#pragma mark - 异步，刷新
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1.0f];
        NSLog(@"group_1 end");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2.0f];
        NSLog(@"group_2 end");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3.0f];
        NSLog(@"group_3 end");
    });
    NSLog(@"main thread");
    /*
     dispatch_group_async()可以监听一组任务是否完成
     */
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"update UI");
    });
#pragma mark - 前面的任务执行结束，才执行
    dispatch_queue_t previousQueue = dispatch_queue_create("GCDDemo.liqun.async", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(previousQueue, ^{
        [NSThread sleepForTimeInterval:2.0f];
        NSLog(@"dispatch_async 1 end");
    });
    dispatch_async(previousQueue, ^{
        [NSThread sleepForTimeInterval:4.0f];
        NSLog(@"dispatch_async 2 end");
    });
    //在前面的任务执行结束后它才执行
    dispatch_barrier_async(previousQueue, ^{
        NSLog(@"dispatch_barrier_async");
        [NSThread sleepForTimeInterval:4.0f];
    });
    dispatch_async(previousQueue, ^{
        [NSThread sleepForTimeInterval:1.0f];
        NSLog(@"dispatch_async 3 end");
    });
#pragma mark - 执行某段代码N次
#if 0
    __weak MultiThreadViewController *weakSelf = self;
    dispatch_apply(5, previousQueue, ^(size_t index) {
        NSString *string = [NSString stringWithFormat:@"dispatch_apply time %ld time", (long)index];
        if (weakSelf) {
            [weakSelf showLabelWithString:string];
        }
    });
#endif
}

- (void)showLabelWithString:(NSString *)string{
    NSLog(@"%@", string);
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
