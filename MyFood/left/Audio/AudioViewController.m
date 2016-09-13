//
//  AudioViewController.m
//  MyFood
//
//  Created by qunlee on 16/9/13.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#import "AudioViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "EQXColor.h"

@interface AudioViewController (){
    BOOL isPlayingShow;
}
@property (nonatomic, strong) AVPlayer *audioPlayer;

@end


@implementation AudioViewController
- (void)viewDidAppear:(BOOL)animated{
    [self becomeFirstResponder];
    [[UIApplication sharedApplication]beginReceivingRemoteControlEvents];
}
- (void)viewDidDisappear:(BOOL)animated{
    [self resignFirstResponder];
    [[UIApplication sharedApplication]endReceivingRemoteControlEvents];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.view setBackgroundColor:[EQXColor colorWithHexString:@"#f8f8f8"]];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"南征北战-我的天空" ofType:@"mp3"];
    NSURL *audioUrl = [NSURL fileURLWithPath: path];
    _audioPlayer = [[AVPlayer alloc]initWithURL:audioUrl];
    [_audioPlayer play];
    isPlayingShow = YES;
    [self setAudioInfo];
}
- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:{
                if (!isPlayingShow) {
                    [_audioPlayer play];
                }
                isPlayingShow = !isPlayingShow;
            }
                break;
            case UIEventSubtypeRemoteControlPause:{
                if (isPlayingShow) {
                    [_audioPlayer pause];
                }
                isPlayingShow = !isPlayingShow;
            }
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:{
                
            }
                break;
            case UIEventSubtypeRemoteControlNextTrack:{
                
            }
                break;
            default:
                break;
        }
    }
}
- (void)setAudioInfo{
    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    NSDictionary *dic = @{MPMediaItemPropertyTitle: @"南征北战-我的天空", MPMediaItemPropertyArtist: @"木小夕", MPMediaItemPropertyArtwork: artWork};
    [[MPNowPlayingInfoCenter defaultCenter]setNowPlayingInfo:dic];
}

@end
