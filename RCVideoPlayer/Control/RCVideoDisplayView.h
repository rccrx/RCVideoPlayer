//
//  RCVideoDisplayView.h
//  RCVideoPlayer
//
//  Created by crx on 2021/4/6.
//

#import <UIKit/UIKit.h>

@class AVPlayer;
@class AVPlayerLayer;

NS_ASSUME_NONNULL_BEGIN

/** 视频显示视图 */
@interface RCVideoDisplayView : UIView

/** 视频显示层 */
@property (nonatomic, readonly) AVPlayerLayer *playerLayer;


/** 创建一个视频显示视图 */
- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player;

@end

NS_ASSUME_NONNULL_END
