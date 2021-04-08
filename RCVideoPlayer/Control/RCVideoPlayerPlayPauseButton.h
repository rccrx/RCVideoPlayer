//
//  RCVideoPlayerPlayPauseButton.h
//  RCVideoPlayer
//
//  Created by crx on 2021/4/6.
//

#import <UIKit/UIKit.h>

@class AVPlayer;

NS_ASSUME_NONNULL_BEGIN

/** 视频播放器的播放暂停按钮
 * normal状态点击为播放，selected状态点击为暂停，因此可以设置这两个状态的图片显示播放暂停图标。
 */
@interface RCVideoPlayerPlayPauseButton : UIButton

/** 播放器 */
@property (nonatomic, strong, readonly) AVPlayer *player;


/** 创建播放暂停按钮 */
- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player;

@end

NS_ASSUME_NONNULL_END
