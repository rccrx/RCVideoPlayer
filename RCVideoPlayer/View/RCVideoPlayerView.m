//
//  RCVideoPlayerView.m
//  RCVideoPlayer
//
//  Created by crx on 2021/4/5.
//

#import "RCVideoPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "RCVideoDisplayView.h"
#import "RCVideoPlayerPlayPauseButton.h"
#import "RCVideoPlayerSlider.h"
#import "RCVideoPlayerTimeLabel.h"


@implementation RCVideoPlayerView

- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)URL {
    if (self = [super initWithFrame:frame]) {
        _player = [AVPlayer playerWithURL:URL];
        
        _displayView = [[RCVideoDisplayView alloc] initWithFrame:CGRectZero player:self.player];
        [self addSubview:self.displayView];
        
        _playPauseButton = [[RCVideoPlayerPlayPauseButton alloc] initWithFrame:CGRectZero player:self.player];
        [self addSubview:self.playPauseButton];
        
        
        _progressSlider = [[RCVideoPlayerSlider alloc] initWithFrame:CGRectZero player:self.player];
        [self addSubview:self.progressSlider];
        
        _durationLabel = [[RCVideoPlayerTimeLabel alloc] initWithFrame:CGRectZero player:self.player isDurationOrCurrent:YES];
        [self addSubview:self.durationLabel];
        
        _currentTimeLabel = [[RCVideoPlayerTimeLabel alloc] initWithFrame:CGRectZero player:self.player isDurationOrCurrent:NO];
        [self addSubview:self.currentTimeLabel];
        
        [self setupSubviewsFrame];
    }
    return self;
}

/** 设置各个控件的frame */
- (void)setupSubviewsFrame {
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    self.displayView.frame = self.bounds;
    self.playPauseButton.frame = CGRectMake(20, height-40, 20, 20);
    
    CGFloat currentX = 20+CGRectGetMaxX(self.playPauseButton.frame);
    self.currentTimeLabel.frame = CGRectMake(currentX, CGRectGetMidY(self.playPauseButton.frame)-5, 40, 10);
    
    CGFloat durationWidth = CGRectGetWidth(self.currentTimeLabel.frame);
    self.durationLabel.frame = CGRectMake(width-20-durationWidth, CGRectGetMinY(self.currentTimeLabel.frame), durationWidth, CGRectGetHeight(self.currentTimeLabel.frame));
    
    CGFloat sliderX = 20+CGRectGetMaxX(self.currentTimeLabel.frame);
    self.progressSlider.frame = CGRectMake(sliderX, CGRectGetMidY(self.playPauseButton.frame)-5, CGRectGetMinX(self.durationLabel.frame)-sliderX-20, 10);
}

- (void)setupPlayPauseButtonWithPlayImage:(UIImage *)playImage pauseImage:(UIImage *)pauseImage {
    [self.playPauseButton setImage:playImage forState:UIControlStateNormal];
    [self.playPauseButton setImage:pauseImage forState:UIControlStateSelected];
}

- (void)setupProgressSliderWithNormalThumbImage:(UIImage *)normalThumbImage highlightedThumbImage:(UIImage *)highlightedThumbImage minimumTrackImage:(UIImage *)minimumTrackImage {
    [self.progressSlider setThumbImage:normalThumbImage forState:UIControlStateNormal];
    [self.progressSlider setThumbImage:highlightedThumbImage forState:UIControlStateHighlighted];
    [self.progressSlider setMinimumTrackImage:minimumTrackImage forState:UIControlStateNormal];
}

@end
