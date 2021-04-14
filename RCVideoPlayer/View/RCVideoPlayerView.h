//
//  RCVideoPlayerView.h
//  RCVideoPlayer
//
//  Created by crx on 2021/4/5.
//

#import <UIKit/UIKit.h>

@class AVPlayer;
@class RCVideoDisplayView;
@class RCVideoPlayerPlayPauseButton;
@class RCVideoPlayerSlider;
@class RCVideoPlayerTimeLabel;
@class RCVideoPlayerSpeedButton;
@class RCVideoPlayerStatusBarView;

NS_ASSUME_NONNULL_BEGIN

/** 视频播放器视图
 * 可以通过子视图成员变量比如playPauseButton直接设置子视图的样式。
 */
@interface RCVideoPlayerView : UIView

/** 播放器，控制播放暂停等功能 */
@property (nonatomic, strong, readonly) AVPlayer *player;
/** 视频显示视图 */
@property (nonatomic, strong, readonly) RCVideoDisplayView *displayView;
/** 播放暂停按钮 */
@property (nonatomic, strong, readonly) RCVideoPlayerPlayPauseButton *playPauseButton;
/** 播放进度条 */
@property (nonatomic, strong, readonly) RCVideoPlayerSlider *progressSlider;
/** 总时长 */
@property (nonatomic, strong, readonly) RCVideoPlayerTimeLabel *durationLabel;
/** 当前时长 */
@property (nonatomic, strong, readonly) RCVideoPlayerTimeLabel *currentTimeLabel;
/** 全屏按钮 */
@property (nonatomic, strong, readonly) UIButton *fullScreenButton;
/** 倍速按钮 */
@property (nonatomic, strong, readonly) RCVideoPlayerSpeedButton *speedButton;
/** 自定制的状态栏 */
@property (nonatomic, strong, readonly) RCVideoPlayerStatusBarView *statusBarView;


/** 创建一个播放器视图，containerViewController是显示这个播放器的视图控制器 */
- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)URL containerViewController:(UIViewController *)containerViewController;

/** 设置播放暂停按钮图片 */
- (void)setupPlayPauseButtonWithPlayImage:(UIImage *)playImage pauseImage:(UIImage *)pauseImage;
/** 设置进度条的轨道图片和滑块图片 */
- (void)setupProgressSliderWithNormalThumbImage:(UIImage *)normalThumbImage highlightedThumbImage:(UIImage *)highlightedThumbImage minimumTrackImage:(UIImage *)minimumTrackImage;
/** 设置全屏按钮图片 */
- (void)setupFullScreenButtonWithImage:(UIImage *)image;

/*---------- 设备旋转时，禁止播放器的UIViewController进行自动旋转，而是手动执行动画进行播放器相应旋转 ----------*/
/** 由包含RCVideoPlayerView的UIViewController重写shouldAutorotate，并在实现中调用这个方法 */
- (BOOL)shouldAutorotate;
/** 由包含RCVideoPlayerView的UIViewController重写supportedInterfaceOrientations，并在实现中调用这个方法 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations;

/*---------- 播放器全屏时，隐藏状态栏，并且可以显示自定义的状态栏来展示时间和电池这些 ----------*/
/** 由包含RCVideoPlayerView的UIViewController重写prefersStatusBarHidden，并在实现中调用这个方法 */
- (BOOL)prefersStatusBarHidden;

@end

NS_ASSUME_NONNULL_END
