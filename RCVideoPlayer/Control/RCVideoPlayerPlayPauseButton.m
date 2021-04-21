//
//  RCVideoPlayerPlayPauseButton.m
//  RCVideoPlayer
//
//  Created by crx on 2021/4/6.
//

#import "RCVideoPlayerPlayPauseButton.h"
#import <AVFoundation/AVFoundation.h>

@implementation RCVideoPlayerPlayPauseButton

- (void)dealloc {
    [self removeObservers];
}

- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player {
    if (self = [super initWithFrame:frame]) {
        _rate = 1.0;
        _player = player;
        
        [self addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addObservers];
    }
    return self;
}

- (void)onClicked:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [self.player setRate:self.rate];
    } else {
        [self.player pause];
    }
}

#pragma mark - 观察者
- (void)addObservers {
    [self addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers {
    [self removeObserver:self forKeyPath:@"rate" context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self && [keyPath isEqualToString:@"rate"]) {
        if (self.selected) {
            [self.player setRate:self.rate];
        }
    }
}

@end
