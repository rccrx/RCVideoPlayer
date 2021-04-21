//
//  RCVideoPlayerRateButton.m
//  RCVideoPlayer
//
//  Created by crx on 2021/4/15.
//

#import "RCVideoPlayerRateButton.h"
#import <AVFoundation/AVFoundation.h>


@interface RCVideoPlayerRateButton ()

@end

@implementation RCVideoPlayerRateButton

- (instancetype)initWithFrame:(CGRect)frame player:(AVPlayer *)player {
    if (self = [super initWithFrame:frame]) {
        _rate = 1.0;
        _player = player;
        
        
        [self setTitle:@"倍速" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)onClicked:(UIButton *)button {
    NSString *title = self.titleLabel.text;
    CGFloat rate = title.floatValue;
    int tempRate = rate==0? 1 : (int)(rate*2);
    tempRate = (tempRate + 1) % 6;
    rate = (tempRate?:1) / 2.0;
    
    [button setTitle:[NSString stringWithFormat:@"%.1f", rate] forState:UIControlStateNormal];
    
    [self setValue:[NSNumber numberWithFloat:rate] forKey:@"rate"]; // 为了KVC可以监测到变化
}

@end
