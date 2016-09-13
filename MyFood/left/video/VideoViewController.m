//
//  VideoViewController.m
//  MyFood
//
//  Created by qunlee on 16/9/6.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "VideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "EQXColor.h"

@interface VideoViewController ()

@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic, strong) UIView *videoView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) MPMoviePlayerController *playController;


@end

@implementation VideoViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    
//    _videoUrl = [NSURL URLWithString:@"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"];
    _videoUrl = [[NSBundle mainBundle]URLForResource:@"warcraft" withExtension:@"mp4"];
    // 全屏
    // MPMoviePlayerViewController
#if 1
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame = self.videoView.bounds;
    [_videoView.layer addSublayer:layer];
    [_player play];
#else
    self.playController.view.frame = self.videoView.bounds;
    [_videoView addSubview:_playController.view];
    [_playController prepareToPlay];
    [_playController play];
#endif
}
#pragma mark - play video
- (UIView *)videoView{
    if (nil == _videoView) {
        _videoView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 200.0f)];
        _videoView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2.0f, 120.0f);
        _videoView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_videoView];
    }
    return _videoView;
}
- (AVPlayer *)player{
    if (nil == _player){
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:_videoUrl];
        _player = [AVPlayer playerWithPlayerItem:item];
    }
    return _player;
}
//MPMoviePlayerController
- (MPMoviePlayerController *)playController{
    if (nil == _playController) {
        _playController = [[MPMoviePlayerController alloc]initWithContentURL:_videoUrl];
        _playController.controlStyle = MPMovieControlStyleDefault;
        _playController.scalingMode = MPMovieScalingModeAspectFit;
    }
    return _playController;
}
@end
