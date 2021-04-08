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

NS_ASSUME_NONNULL_BEGIN

/** 视频播放器视图 */
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


/** 创建一个播放器视图 */
- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)URL;

/** 设置播放暂停按钮图片，也可以直接通过playPauseButton设置normal和selected状态的显示 */
- (void)setupPlayPauseButtonWithPlayImage:(UIImage *)playImage pauseImage:(UIImage *)pauseImage;
/** 设置进度条的轨道图片和滑块图片 */
- (void)setupProgressSliderWithNormalThumbImage:(UIImage *)normalThumbImage highlightedThumbImage:(UIImage *)highlightedThumbImage minimumTrackImage:(UIImage *)minimumTrackImage;

@end

NS_ASSUME_NONNULL_END
