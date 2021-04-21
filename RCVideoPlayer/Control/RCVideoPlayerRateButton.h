//
//  RCVideoPlayerRateButton.h
//  RCVideoPlayer
//
//  Created by crx on 2021/4/15.
//

#import <UIKit/UIKit.h>

@class AVPlayer;

NS_ASSUME_NONNULL_BEGIN

/** 倍速按钮 */
@interface RCVideoPlayerRateButton : UIButton

/** 播放器 */
@property (nonatomic, strong, readonly) AVPlayer *player;
/** 已选择的速率，可用KVO监测变化 */
@property (nonatomic, assign, readonly) float rate;


/** 创建倍速按钮 */
- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player;

@end

NS_ASSUME_NONNULL_END
