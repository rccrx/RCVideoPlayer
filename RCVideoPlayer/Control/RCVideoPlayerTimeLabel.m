//
//  RCVideoPlayerTimeLabel.m
//  RCVideoPlayer
//
//  Created by crx on 2021/4/8.
//

#import "RCVideoPlayerTimeLabel.h"
#import <AVFoundation/AVFoundation.h>

@interface RCVideoPlayerTimeLabel ()
/** YES表示显示总时长，NO表示显示当前时长 */
@property (nonatomic, assign) BOOL isDuration;
/** 时间观察者token */
@property (nonatomic, strong) id timeObserverToken;
@end

@implementation RCVideoPlayerTimeLabel

- (void)dealloc {
    [self removeObservers];
}

- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player isDurationOrCurrent:(BOOL)isDuration {
    if (self = [super initWithFrame:frame]) {
        _player = player;
        _isDuration = isDuration;
        
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:10];
        self.textColor = [UIColor whiteColor];
        self.text = [self timeTextFromCMTime:kCMTimeZero];
        
        [self addObservers];
    }
    return self;
}

- (void)addObservers {
    if (self.isDuration) {
        AVKeyValueStatus status = [self.player.currentItem.asset statusOfValueForKey:@"duration" error:nil];
        if (status != AVKeyValueStatusLoaded) {
            __weak typeof(self) weakSelf = self;
            [self.player.currentItem.asset loadValuesAsynchronouslyForKeys:@[@"duration"] completionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.text = [weakSelf timeTextFromCMTime:weakSelf.player.currentItem.asset.duration];
                });
            }];
        }
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    _timeObserverToken = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, NSEC_PER_SEC) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        weakSelf.text = [weakSelf timeTextFromCMTime:time];
    }];
}

- (void)removeObservers {
    if (self.isDuration) {
        return;
    }
    
    [self.player removeTimeObserver:self.timeObserverToken];
}

- (NSString *)timeTextFromCMTime:(CMTime)time {
    NSInteger seconds = (NSInteger)CMTimeGetSeconds(time);
    NSInteger minute = seconds / 60;
    NSInteger second = seconds % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", minute, second];
}

@end
