//
//  RCVideoPlayerStatusBarView.m
//  RCVideoPlayer
//
//  Created by crx on 2021/4/14.
//

#import "RCVideoPlayerStatusBarView.h"

@interface RCVideoPlayerStatusBarView ()
/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation RCVideoPlayerStatusBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.font = [UIFont systemFontOfSize:11];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.text = @"01:01";
        [self addSubview:self.timeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    CGFloat timeWidth = 100;
    self.timeLabel.frame = CGRectMake((width-timeWidth)/2.0, 0, timeWidth, height);
}

@end
