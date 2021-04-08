//
//  RCVideoPlayerSlider.m
//  RCVideoPlayer
//
//  Created by crx on 2021/4/7.
//

#import "RCVideoPlayerSlider.h"
#import <AVFoundation/AVFoundation.h>

@interface RCVideoPlayerSlider ()
/** 时间观察者token */
@property (nonatomic, strong) id timeObserverToken;
@end

@implementation RCVideoPlayerSlider

#pragma mark - 初始化 与 生命周期
- (void)dealloc {
    [self removeObservers];
}

- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player {
    if (self = [super initWithFrame:frame]) {
        _player = player;
        
        [self addTarget:self action:@selector(onValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
        [self addGestureRecognizer:tapGesture];
        
        [self addObservers];
    }
    return self;
}

#pragma mark - 响应事件
- (void)onValueChanged:(UISlider *)slider forEvent:(UIEvent *)event {
    NSArray<UITouch *> *touches = event.allTouches.allObjects;
    UITouch *touch = touches.firstObject;
    if (touch.phase == UITouchPhaseEnded) {
        [self playerSeekToTimeWithValue:slider.value];
        NSLog(@"ended value = %f", slider.value);
    } else if (touch.phase == UITouchPhaseMoved) {
        NSLog(@"moved value = %f", slider.value);
    }
}

- (void)onTapped:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self];
    CGFloat value = location.x / CGRectGetWidth(self.frame);
    [self playerSeekToTimeWithValue:value];
}

#pragma mark - 观察者
- (void)addObservers {
    __weak typeof(self) weakSelf = self;
    _timeObserverToken = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, NSEC_PER_SEC) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CGFloat currentTime = CMTimeGetSeconds(time);
        CGFloat duration = CMTimeGetSeconds(weakSelf.player.currentItem.duration);
        CGFloat value = currentTime / duration;
        [weakSelf setValue:value];
    }];
}

- (void)removeObservers {
    [self.player removeTimeObserver:self.timeObserverToken];
}

#pragma mark - 私有方法
- (void)playerSeekToTimeWithValue:(CGFloat)value {
    CGFloat duration = CMTimeGetSeconds(self.player.currentItem.duration);
    CMTime seekTime = CMTimeMakeWithSeconds(value*duration, NSEC_PER_SEC); // 如果timescale写1则seconds的小数部分如7.581会有警告“warning: error of -0.581 introduced due to very low timescale”，且如果timescale为1则得到的CMTime获得的seconds没有小数部分，而NSEC_PER_SEC会有小数部分。
    [self.player seekToTime:seekTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

@end
