//
//  RCVideoPlayerSpeedButton.h
//  RCVideoPlayer
//
//  Created by crx on 2021/4/13.
//

#import <UIKit/UIKit.h>

@class AVPlayer;

NS_ASSUME_NONNULL_BEGIN

/** 倍速按钮 */
@interface RCVideoPlayerSpeedButton : UIButton

/** 播放器 */
@property (nonatomic, strong, readonly) AVPlayer *player;


/** 创建倍速按钮 */
- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player;

@end

NS_ASSUME_NONNULL_END
