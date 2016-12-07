//
//  NSThreadDemoViewController.m
//  MyFood
//
//  Created by qunlee on 16/12/6.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "NSThreadDemoViewController.h"
#import "EQXColor.h"

@interface NSThreadDemoViewController (){
    NSInteger ticketNum;
    NSLock *lock;
}
@property (nonatomic, strong) NSDictionary *commonData;
@end

@implementation NSThreadDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [EQXColor colorWithHexString:@"#f8f8f8"];
#if 0
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(threadAction1) object:nil];
    [thread start];
    [thread cancel];
    [NSThread detachNewThreadSelector:@selector(threadAction2) toTarget:self withObject:nil];
    [NSThread exit];
    //当前线程
    [NSThread currentThread];
    //主线程
    [NSThread mainThread];
    
    //分线程调用
    [self performSelector:@selector(threadAction1) withObject:nil afterDelay:2.0f];
    //主线程调用
    [self performSelectorOnMainThread:@selector(threadAction1) withObject:nil waitUntilDone:YES];
    //后台线程调用
    [self performSelectorInBackground:@selector(threadAction1) withObject:nil];
#endif
    //demo1
//    [self addDemo1];
    lock = [[NSLock alloc]init];
    [self addDemo2];
}
- (void)threadAction1{
    NSLog(@"thread1");
}
- (void)threadAction2{
    NSLog(@"thread2");
}
#pragma mark - demo1
- (void)addDemo1{
    ticketNum = 50;
    NSThread *beijingWindow = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    beijingWindow.name = @"北京窗口";
    [beijingWindow start];
    NSThread *guangZhouWindow = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    guangZhouWindow.name = @"广州窗口";
    [guangZhouWindow start];
}
- (void)saleTicket{
    while (1) {
        @synchronized (self) {
            if (ticketNum > 0) {
                ticketNum --;
                NSLog(@"剩余票数: %ld,窗口: %@", ticketNum + 1, [NSThread currentThread].name);
                [NSThread sleepForTimeInterval:0.2f];
            }else{
                break;
            }
        }
    }
}
#pragma mark - demo2
- (void)addDemo2{
    ticketNum = 50;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(threadExitNotice) name:NSThreadWillExitNotification object:nil];
    NSThread *window1 = [[NSThread alloc]initWithTarget:self selector:@selector(thread1) object:nil];
    [window1 start];
    NSThread *window2 = [[NSThread alloc]initWithTarget:self selector:@selector(thread2) object:nil];
    [window2 start];
    
    [self performSelector:@selector(saleTicket2) onThread:window1 withObject:nil waitUntilDone:NO];
    [self performSelector:@selector(saleTicket2) onThread:window2 withObject:nil waitUntilDone:NO];
}
- (void)saleTicket2{
    while (1) {
        [lock lock];
        if (ticketNum > 0) {
            ticketNum --;
            NSLog(@"剩余票数: %ld,窗口: %@", ticketNum + 1, [NSThread currentThread].name);
            [NSThread sleepForTimeInterval:0.2f];//0.2 * 50 = 10
        }else{
            if ([NSThread currentThread].isCancelled) {
                break;
            }else{
                NSLog(@"%@ 售卖完毕", [NSThread currentThread].name);
                [[NSThread currentThread] cancel];
                CFRunLoopStop(CFRunLoopGetCurrent());
            }
        }
        [lock unlock];
    }
}
- (void)thread1{
    [NSThread currentThread].name = @"北京窗口";
    NSRunLoop *runLoop1 = [NSRunLoop currentRunLoop];
    [runLoop1 runUntilDate:[NSDate date]];
}
- (void)thread2{
    [NSThread currentThread].name = @"广州窗口";
    NSRunLoop *runLoop2 = [NSRunLoop currentRunLoop];
    [runLoop2 runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:5]];
}
- (void)threadExitNotice{
    NSLog(@"NSThread exit");
}
/** 无锁输出，有错误情况
 2016-12-06 16:46:34.852 MyFood[4717:391517] 剩余票数: 50,窗口: 广州窗口
 2016-12-06 16:46:34.852 MyFood[4717:391516] 剩余票数: 50,窗口: 北京窗口
 2016-12-06 16:46:35.056 MyFood[4717:391517] 剩余票数: 48,窗口: 广州窗口
 2016-12-06 16:46:35.056 MyFood[4717:391516] 剩余票数: 48,窗口: 北京窗口
 2016-12-06 16:46:35.262 MyFood[4717:391516] 剩余票数: 46,窗口: 北京窗口
 2016-12-06 16:46:35.262 MyFood[4717:391517] 剩余票数: 46,窗口: 广州窗口
 2016-12-06 16:46:35.465 MyFood[4717:391517] 剩余票数: 44,窗口: 广州窗口
 2016-12-06 16:46:35.465 MyFood[4717:391516] 剩余票数: 44,窗口: 北京窗口
 2016-12-06 16:46:35.670 MyFood[4717:391516] 剩余票数: 42,窗口: 北京窗口
 2016-12-06 16:46:35.670 MyFood[4717:391517] 剩余票数: 42,窗口: 广州窗口
 2016-12-06 16:46:35.873 MyFood[4717:391516] 剩余票数: 40,窗口: 北京窗口
 2016-12-06 16:46:35.873 MyFood[4717:391517] 剩余票数: 40,窗口: 广州窗口
 2016-12-06 16:46:36.078 MyFood[4717:391517] 剩余票数: 38,窗口: 广州窗口
 2016-12-06 16:46:36.078 MyFood[4717:391516] 剩余票数: 38,窗口: 北京窗口
 2016-12-06 16:46:36.283 MyFood[4717:391516] 剩余票数: 36,窗口: 北京窗口
 2016-12-06 16:46:36.283 MyFood[4717:391517] 剩余票数: 36,窗口: 广州窗口
 2016-12-06 16:46:36.484 MyFood[4717:391516] 剩余票数: 34,窗口: 北京窗口
 2016-12-06 16:46:36.484 MyFood[4717:391517] 剩余票数: 34,窗口: 广州窗口
 2016-12-06 16:46:36.689 MyFood[4717:391516] 剩余票数: 32,窗口: 北京窗口
 2016-12-06 16:46:36.689 MyFood[4717:391517] 剩余票数: 32,窗口: 广州窗口
 2016-12-06 16:46:36.892 MyFood[4717:391516] 剩余票数: 30,窗口: 北京窗口
 2016-12-06 16:46:36.895 MyFood[4717:391517] 剩余票数: 29,窗口: 广州窗口
 2016-12-06 16:46:37.096 MyFood[4717:391516] 剩余票数: 28,窗口: 北京窗口
 2016-12-06 16:46:37.099 MyFood[4717:391517] 剩余票数: 27,窗口: 广州窗口
 2016-12-06 16:46:37.299 MyFood[4717:391516] 剩余票数: 26,窗口: 北京窗口
 2016-12-06 16:46:37.302 MyFood[4717:391517] 剩余票数: 25,窗口: 广州窗口
 2016-12-06 16:46:37.504 MyFood[4717:391516] 剩余票数: 24,窗口: 北京窗口
 2016-12-06 16:46:37.506 MyFood[4717:391517] 剩余票数: 23,窗口: 广州窗口
 2016-12-06 16:46:37.708 MyFood[4717:391516] 剩余票数: 22,窗口: 北京窗口
 2016-12-06 16:46:37.711 MyFood[4717:391517] 剩余票数: 21,窗口: 广州窗口
 2016-12-06 16:46:37.913 MyFood[4717:391516] 剩余票数: 20,窗口: 北京窗口
 2016-12-06 16:46:37.916 MyFood[4717:391517] 剩余票数: 19,窗口: 广州窗口
 2016-12-06 16:46:38.118 MyFood[4717:391516] 剩余票数: 18,窗口: 北京窗口
 2016-12-06 16:46:38.120 MyFood[4717:391517] 剩余票数: 17,窗口: 广州窗口
 2016-12-06 16:46:38.323 MyFood[4717:391516] 剩余票数: 16,窗口: 北京窗口
 2016-12-06 16:46:38.324 MyFood[4717:391517] 剩余票数: 15,窗口: 广州窗口
 2016-12-06 16:46:38.529 MyFood[4717:391516] 剩余票数: 14,窗口: 北京窗口
 2016-12-06 16:46:38.529 MyFood[4717:391517] 剩余票数: 14,窗口: 广州窗口
 2016-12-06 16:46:38.733 MyFood[4717:391516] 剩余票数: 12,窗口: 北京窗口
 2016-12-06 16:46:38.733 MyFood[4717:391517] 剩余票数: 12,窗口: 广州窗口
 2016-12-06 16:46:38.936 MyFood[4717:391517] 剩余票数: 10,窗口: 广州窗口
 2016-12-06 16:46:38.936 MyFood[4717:391516] 剩余票数: 10,窗口: 北京窗口
 2016-12-06 16:46:39.141 MyFood[4717:391517] 剩余票数: 8,窗口: 广州窗口
 2016-12-06 16:46:39.141 MyFood[4717:391516] 剩余票数: 8,窗口: 北京窗口
 2016-12-06 16:46:39.345 MyFood[4717:391516] 剩余票数: 6,窗口: 北京窗口
 2016-12-06 16:46:39.345 MyFood[4717:391517] 剩余票数: 6,窗口: 广州窗口
 2016-12-06 16:46:39.551 MyFood[4717:391517] 剩余票数: 4,窗口: 广州窗口
 2016-12-06 16:46:39.551 MyFood[4717:391516] 剩余票数: 4,窗口: 北京窗口
 2016-12-06 16:46:39.755 MyFood[4717:391517] 剩余票数: 2,窗口: 广州窗口
 2016-12-06 16:46:39.755 MyFood[4717:391516] 剩余票数: 2,窗口: 北京窗口
 */
/** 线程加锁，线程同步 正常
 2016-12-06 16:50:26.871 MyFood[4793:396057] 剩余票数: 50,窗口: 广州窗口
 2016-12-06 16:50:27.074 MyFood[4793:396056] 剩余票数: 49,窗口: 北京窗口
 2016-12-06 16:50:27.279 MyFood[4793:396057] 剩余票数: 48,窗口: 广州窗口
 2016-12-06 16:50:27.481 MyFood[4793:396056] 剩余票数: 47,窗口: 北京窗口
 2016-12-06 16:50:27.686 MyFood[4793:396057] 剩余票数: 46,窗口: 广州窗口
 2016-12-06 16:50:27.889 MyFood[4793:396056] 剩余票数: 45,窗口: 北京窗口
 2016-12-06 16:50:28.094 MyFood[4793:396057] 剩余票数: 44,窗口: 广州窗口
 2016-12-06 16:50:28.299 MyFood[4793:396056] 剩余票数: 43,窗口: 北京窗口
 2016-12-06 16:50:28.501 MyFood[4793:396057] 剩余票数: 42,窗口: 广州窗口
 2016-12-06 16:50:28.704 MyFood[4793:396056] 剩余票数: 41,窗口: 北京窗口
 2016-12-06 16:50:28.913 MyFood[4793:396057] 剩余票数: 40,窗口: 广州窗口
 2016-12-06 16:50:29.130 MyFood[4793:396056] 剩余票数: 39,窗口: 北京窗口
 2016-12-06 16:50:29.334 MyFood[4793:396057] 剩余票数: 38,窗口: 广州窗口
 2016-12-06 16:50:29.537 MyFood[4793:396056] 剩余票数: 37,窗口: 北京窗口
 2016-12-06 16:50:29.742 MyFood[4793:396057] 剩余票数: 36,窗口: 广州窗口
 2016-12-06 16:50:29.943 MyFood[4793:396056] 剩余票数: 35,窗口: 北京窗口
 2016-12-06 16:50:30.149 MyFood[4793:396057] 剩余票数: 34,窗口: 广州窗口
 2016-12-06 16:50:30.353 MyFood[4793:396056] 剩余票数: 33,窗口: 北京窗口
 2016-12-06 16:50:30.557 MyFood[4793:396057] 剩余票数: 32,窗口: 广州窗口
 2016-12-06 16:50:30.763 MyFood[4793:396056] 剩余票数: 31,窗口: 北京窗口
 2016-12-06 16:50:30.964 MyFood[4793:396057] 剩余票数: 30,窗口: 广州窗口
 2016-12-06 16:50:31.169 MyFood[4793:396056] 剩余票数: 29,窗口: 北京窗口
 2016-12-06 16:50:31.374 MyFood[4793:396057] 剩余票数: 28,窗口: 广州窗口
 2016-12-06 16:50:31.579 MyFood[4793:396056] 剩余票数: 27,窗口: 北京窗口
 2016-12-06 16:50:31.781 MyFood[4793:396057] 剩余票数: 26,窗口: 广州窗口
 2016-12-06 16:50:31.987 MyFood[4793:396056] 剩余票数: 25,窗口: 北京窗口
 2016-12-06 16:50:32.192 MyFood[4793:396057] 剩余票数: 24,窗口: 广州窗口
 2016-12-06 16:50:32.396 MyFood[4793:396056] 剩余票数: 23,窗口: 北京窗口
 2016-12-06 16:50:32.601 MyFood[4793:396057] 剩余票数: 22,窗口: 广州窗口
 2016-12-06 16:50:32.806 MyFood[4793:396056] 剩余票数: 21,窗口: 北京窗口
 2016-12-06 16:50:33.010 MyFood[4793:396057] 剩余票数: 20,窗口: 广州窗口
 2016-12-06 16:50:33.213 MyFood[4793:396056] 剩余票数: 19,窗口: 北京窗口
 2016-12-06 16:50:33.418 MyFood[4793:396057] 剩余票数: 18,窗口: 广州窗口
 2016-12-06 16:50:33.622 MyFood[4793:396056] 剩余票数: 17,窗口: 北京窗口
 2016-12-06 16:50:33.824 MyFood[4793:396057] 剩余票数: 16,窗口: 广州窗口
 2016-12-06 16:50:34.029 MyFood[4793:396056] 剩余票数: 15,窗口: 北京窗口
 2016-12-06 16:50:34.234 MyFood[4793:396057] 剩余票数: 14,窗口: 广州窗口
 2016-12-06 16:50:34.435 MyFood[4793:396056] 剩余票数: 13,窗口: 北京窗口
 2016-12-06 16:50:34.640 MyFood[4793:396057] 剩余票数: 12,窗口: 广州窗口
 2016-12-06 16:50:34.843 MyFood[4793:396056] 剩余票数: 11,窗口: 北京窗口
 2016-12-06 16:50:35.047 MyFood[4793:396057] 剩余票数: 10,窗口: 广州窗口
 2016-12-06 16:50:35.252 MyFood[4793:396056] 剩余票数: 9,窗口: 北京窗口
 2016-12-06 16:50:35.457 MyFood[4793:396057] 剩余票数: 8,窗口: 广州窗口
 2016-12-06 16:50:35.662 MyFood[4793:396056] 剩余票数: 7,窗口: 北京窗口
 2016-12-06 16:50:35.866 MyFood[4793:396057] 剩余票数: 6,窗口: 广州窗口
 2016-12-06 16:50:36.071 MyFood[4793:396056] 剩余票数: 5,窗口: 北京窗口
 2016-12-06 16:50:36.276 MyFood[4793:396057] 剩余票数: 4,窗口: 广州窗口
 2016-12-06 16:50:36.480 MyFood[4793:396056] 剩余票数: 3,窗口: 北京窗口
 2016-12-06 16:50:36.685 MyFood[4793:396057] 剩余票数: 2,窗口: 广州窗口
 2016-12-06 16:50:36.889 MyFood[4793:396056] 剩余票数: 1,窗口: 北京窗口
 */
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
