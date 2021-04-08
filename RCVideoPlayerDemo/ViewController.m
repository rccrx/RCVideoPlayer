//
//  ViewController.m
//  RCVideoPlayerDemo
//
//  Created by crx on 2021/4/5.
//

#import "ViewController.h"
#import "RCVideoPlayerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@ %@", [self class], NSStringFromSelector(_cmd));
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Movie" withExtension:@"mov"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Movie" withExtension:@"m4v"];
//    NSURL *url = [NSURL URLWithString:@"http://k6.kekenet.com/Sound/2019/07/angke11.mp4"];
    RCVideoPlayerView *playerView = [[RCVideoPlayerView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 200) URL:url];
    playerView.backgroundColor = [UIColor blueColor];
    [playerView setupPlayPauseButtonWithPlayImage:[UIImage imageNamed:@"play"] pauseImage:[UIImage imageNamed:@"pause"]];
    [playerView setupProgressSliderWithNormalThumbImage:[UIImage imageNamed:@"thumb-normal"] highlightedThumbImage:[UIImage imageNamed:@"thumb-highlighted"] minimumTrackImage:[UIImage imageNamed:@"track"]];
    [self.view addSubview:playerView];
}

@end
