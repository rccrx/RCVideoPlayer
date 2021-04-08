//
//  RCVideoPlayerSlider.h
//  RCVideoPlayer
//
//  Created by crx on 2021/4/7.
//

#import <UIKit/UIKit.h>

@class AVPlayer;

NS_ASSUME_NONNULL_BEGIN

/** 播放进度条 */
@interface RCVideoPlayerSlider : UISlider

/** 播放器 */
@property (nonatomic, strong, readonly) AVPlayer *player;


/** 创建播放进度条 */
- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player;

@end

NS_ASSUME_NONNULL_END
