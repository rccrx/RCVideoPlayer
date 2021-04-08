//
//  RCVideoDisplayView.m
//  RCVideoPlayer
//
//  Created by crx on 2021/4/6.
//

#import "RCVideoDisplayView.h"
#import <AVFoundation/AVFoundation.h>


@implementation RCVideoDisplayView

#pragma mark - 设置playerLayer
+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}

#pragma mark - 初始化，并关联播放器player
- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player {
    if (self = [super initWithFrame:frame]) {
        self.playerLayer.player = player;
    }
    return self;
}

@end
