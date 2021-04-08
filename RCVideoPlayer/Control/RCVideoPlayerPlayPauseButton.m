//
//  RCVideoPlayerPlayPauseButton.m
//  RCVideoPlayer
//
//  Created by crx on 2021/4/6.
//

#import "RCVideoPlayerPlayPauseButton.h"
#import <AVFoundation/AVFoundation.h>

@implementation RCVideoPlayerPlayPauseButton

- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player {
    if (self = [super initWithFrame:frame]) {
        _player = player;
        
        [self addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)onClicked:(UIButton *)button {
    if (button.selected) {
        [self.player pause];
    } else {
        [self.player play];
    }
    button.selected = !button.selected;
}

@end
