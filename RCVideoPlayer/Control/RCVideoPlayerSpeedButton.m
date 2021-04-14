//
//  RCVideoPlayerSpeedButton.m
//  RCVideoPlayer
//
//  Created by crx on 2021/4/13.
//

#import "RCVideoPlayerSpeedButton.h"
#import <AVFoundation/AVFoundation.h>

@implementation RCVideoPlayerSpeedButton

- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player {
    if (self = [super initWithFrame:frame]) {
        _player = player;
        
        
        [self setTitle:@"倍速" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)onClicked:(UIButton *)button {
}

@end
