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
#import "RCVideoPlayerRateButton.h"
#import "RCVideoPlayerStatusBarView.h"


@interface RCVideoPlayerView ()
/** 变形前的frame */
@property (nonatomic, assign) CGRect orginalFrame;
/** 显示这个播放器的视图控制器 */
@property (nonatomic, weak) UIViewController *containerViewController;
@end

@implementation RCVideoPlayerView

#pragma mark - 初始化 与 生命周期
- (void)dealloc {
    NSLog(@"%@ %@", [self class], NSStringFromSelector(_cmd));
    [self removeObservers];
}

- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)URL containerViewController:(nonnull UIViewController *)containerViewController {
    if (self = [super initWithFrame:frame]) {
        _orginalFrame = frame;
        _player = [AVPlayer playerWithURL:URL];
        _containerViewController = containerViewController;
        self.backgroundColor = [UIColor blackColor];
        
        
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
        
        _fullScreenButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.fullScreenButton addTarget:self action:@selector(onFullScreenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.fullScreenButton];
        
        _rateButton = [[RCVideoPlayerRateButton alloc] initWithFrame:CGRectZero player:self.player];
        [self addSubview:self.rateButton];
        
        _statusBarView = [[RCVideoPlayerStatusBarView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.statusBarView];
        
        
        [self setupSubviewsFrame];
        
        [self addObservers];
    }
    return self;
}

/** 设置各个控件的frame（layoutSubviews会在首次显示时调用或者修改父视图即self的frame时调用，“旋转+改frame”动画开始之前也会调用，所以为了动画效果不能在layoutSubviews中写修改子视图frame的代码） */
- (void)setupSubviewsFrame {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat marginH = 10; /**< 控件之间的水平间距 */
    CGFloat playMarginV = 20; /**< 播放按钮距离屏幕底部的垂直间距 */
    CGFloat rateMarginV = 0; /**< 倍速按钮距离屏幕底部的垂直间距 */
    BOOL isFullScreen = !CGRectEqualToRect(self.frame, self.orginalFrame); // 是否是全屏状态
    
    // 设置全屏和非全屏的区别
    if (isFullScreen) {
        playMarginV = 60;
        rateMarginV = 20;
        self.rateButton.hidden = NO;
        self.statusBarView.hidden = NO;
    } else {
        playMarginV = 20;
        rateMarginV = 0;
        self.rateButton.hidden = YES;
        self.statusBarView.hidden = YES;
    }
    
    
    // 设置子视图的frame
    
    self.displayView.frame = self.bounds;
    
    CGFloat playPauseHeight = 20;
    self.playPauseButton.frame = CGRectMake(marginH, height-playPauseHeight-playMarginV, 20, playPauseHeight);
    
    CGFloat currentX = marginH+CGRectGetMaxX(self.playPauseButton.frame);
    CGFloat currentHeight = 10;
    self.currentTimeLabel.frame = CGRectMake(currentX, CGRectGetMidY(self.playPauseButton.frame)-currentHeight/2.0, 30, currentHeight);
    
    CGFloat fullWidth = CGRectGetWidth(self.playPauseButton.frame);
    self.fullScreenButton.frame = CGRectMake(width-marginH-fullWidth, CGRectGetMinY(self.playPauseButton.frame), fullWidth, CGRectGetHeight(self.playPauseButton.frame));
    
    CGFloat durationWidth = CGRectGetWidth(self.currentTimeLabel.frame);
    self.durationLabel.frame = CGRectMake(CGRectGetMinX(self.fullScreenButton.frame)-marginH-durationWidth, CGRectGetMinY(self.currentTimeLabel.frame), durationWidth, CGRectGetHeight(self.currentTimeLabel.frame));
    
    CGFloat sliderX = marginH+CGRectGetMaxX(self.currentTimeLabel.frame);
    CGFloat sliderHeight = 10;
    self.progressSlider.frame = CGRectMake(sliderX, CGRectGetMidY(self.playPauseButton.frame)-sliderHeight/2.0, CGRectGetMinX(self.durationLabel.frame)-sliderX-marginH, sliderHeight);
    
    CGFloat rateWidth = 40;
    CGFloat rateHeight = 20;
    self.rateButton.frame = CGRectMake(width-marginH-rateWidth, height-rateMarginV-rateHeight, rateWidth, rateHeight);
    
    self.statusBarView.frame = CGRectMake(0, 0, width, 20);
}

#pragma mark - 观察者
- (void)addObservers {
    [self addOrientaionNotificationObserver];
    [self addRateButtonObserver];
}

- (void)removeObservers {
    [self removeOrientaionNotificationObserver];
    [self removeRateButtonObserver];
}

#pragma mark - 公开方法
- (void)setupPlayPauseButtonWithPlayImage:(UIImage *)playImage pauseImage:(UIImage *)pauseImage {
    [self.playPauseButton setImage:playImage forState:UIControlStateNormal];
    [self.playPauseButton setImage:pauseImage forState:UIControlStateSelected];
}

- (void)setupProgressSliderWithNormalThumbImage:(UIImage *)normalThumbImage highlightedThumbImage:(UIImage *)highlightedThumbImage minimumTrackImage:(UIImage *)minimumTrackImage {
    [self.progressSlider setThumbImage:normalThumbImage forState:UIControlStateNormal];
    [self.progressSlider setThumbImage:highlightedThumbImage forState:UIControlStateHighlighted];
    [self.progressSlider setMinimumTrackImage:minimumTrackImage forState:UIControlStateNormal];
}

- (void)setupFullScreenButtonWithImage:(UIImage *)image {
    [self.fullScreenButton setImage:image forState:UIControlStateNormal];
}

#pragma mark - 全屏相关
- (void)onFullScreenButtonClicked:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [self animateRotationWithTargetDeviceOrientation:UIDeviceOrientationLandscapeLeft];
    } else {
        [self animateRotationWithTargetDeviceOrientation:UIDeviceOrientationPortrait];
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

// 调用setNeedsStatusBarAppearanceUpdate时会自动调用这个方法判断状态栏该隐藏还是显示
- (BOOL)prefersStatusBarHidden {
    BOOL isFullScreen = !CGRectEqualToRect(self.frame, self.orginalFrame); // 判断现在是否是全屏状态
    return isFullScreen;
}

- (void)addOrientaionNotificationObserver {
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceOrientationDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf animateRotationWithTargetDeviceOrientation:[UIDevice currentDevice].orientation];
    }];
}

- (void)removeOrientaionNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 根据目标朝向进行旋转 */
- (void)animateRotationWithTargetDeviceOrientation:(UIDeviceOrientation)orientation {
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
        CGAffineTransform transform;
        if (orientation == UIDeviceOrientationLandscapeLeft) {
            transform = CGAffineTransformMakeRotation(M_PI_2); // 变形之后frame失效
        } else {
            transform = CGAffineTransformMakeRotation(-M_PI_2);
        }
        BOOL isFullScreen = !CGRectEqualToRect(self.frame, self.orginalFrame); // 是否是全屏状态
        NSTimeInterval duration = isFullScreen?0.5:0.25; // 旋转180度的时间是90度的两倍，否则动画太快
        [UIView animateWithDuration:duration animations:^{
            self.transform = transform;
            self.bounds = CGRectMake(0, 0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds));
            self.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2.0, CGRectGetHeight([UIScreen mainScreen].bounds)/2.0);
            
            // 由于动画开始执行之后，马上调用layoutSubviews，然后才用duration时间播放动画，所以不能在layoutSubviews中修改子视图布局，会影响动画效果（变成马上根据最新frame更新各个子视图显示然后才播放动画改变self大小位置）
            [self setupSubviewsFrame]; // hidden不会有动画效果，frame修改有动画效果
        } completion:^(BOOL finished) {
            if (finished) {
                [self.containerViewController setNeedsStatusBarAppearanceUpdate];
            }
        }];
    } else if (orientation == UIDeviceOrientationPortrait) {
        [UIView animateWithDuration:0.25 animations:^{
            self.transform = CGAffineTransformMakeRotation(0); // 恢复旋转0度的布局
            self.frame = self.orginalFrame;
            [self setupSubviewsFrame];
        } completion:^(BOOL finished) {
            if (finished) {
                [self.containerViewController setNeedsStatusBarAppearanceUpdate];
            }
        }];
    }
}

#pragma mark - 倍速相关
- (void)addRateButtonObserver {
    [self.rateButton addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeRateButtonObserver {
    [self.rateButton removeObserver:self forKeyPath:@"rate" context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.rateButton && [keyPath isEqualToString:@"rate"]) {
        self.playPauseButton.rate = self.rateButton.rate;
    }
}

@end
