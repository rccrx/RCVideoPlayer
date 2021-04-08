//
//  RCVideoPlayerTimeLabel.h
//  RCVideoPlayer
//
//  Created by crx on 2021/4/8.
//

#import <UIKit/UIKit.h>

@class AVPlayer;

NS_ASSUME_NONNULL_BEGIN

/** 用于显示视频时长、当前时长 */
@interface RCVideoPlayerTimeLabel : UILabel

/** 播放器 */
@property (nonatomic, strong, readonly) AVPlayer *player;


/** 创建时间标签
 @param isDuration YES表示创建一个显示总时长的时间标签，NO表示创建一个显示当前时长的时间标签。
 */
- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player isDurationOrCurrent:(BOOL)isDuration;

@end

NS_ASSUME_NONNULL_END
