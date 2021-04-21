//
//  ViewController.m
//  RCVideoPlayerDemo
//
//  Created by crx on 2021/4/5.
//

#import "ViewController.h"
#import "RCVideoPlayerView.h"

@interface ViewController ()
/** 视频播放器 */
@property (nonatomic, strong) RCVideoPlayerView *playerView;
@end

@implementation ViewController

#pragma mark - 全屏——旋转相关方法
- (BOOL)shouldAutorotate {
    NSLog(@"%@ %@: device orientation = %ld", [self class], NSStringFromSelector(_cmd), [UIDevice currentDevice].orientation);
    return [self.playerView shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    NSLog(@"%@ %@", [self class], NSStringFromSelector(_cmd));
    return [self.playerView supportedInterfaceOrientations];
}

#pragma mark - 全屏——状态栏相关方法
- (BOOL)prefersStatusBarHidden {
    return [self.playerView prefersStatusBarHidden];
}

#pragma mark - 生命周期

- (void)dealloc {
    NSLog(@"%@ %@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@ %@", [self class], NSStringFromSelector(_cmd));
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Movie" withExtension:@"mov"];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Movie" withExtension:@"m4v"];
//    NSURL *url = [NSURL URLWithString:@"http://k6.kekenet.com/Sound/2019/07/angke11.mp4"];
    NSURL *url = [NSURL URLWithString:@"https://vd2.bdstatic.com/mda-jk1daq6ynn4gak8d/mda-jk1daq6ynn4gak8d.mp4"]; // HTTP的URL会完全下载完视频之后，才会在AVPlayerLayer显示，才可以开始播放
    RCVideoPlayerView *playerView = [[RCVideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame)/16.0*9.0) URL:url containerViewController:self];
    [playerView setupPlayPauseButtonWithPlayImage:[UIImage imageNamed:@"play"] pauseImage:[UIImage imageNamed:@"pause"]];
    [playerView setupProgressSliderWithNormalThumbImage:[UIImage imageNamed:@"thumb-normal"] highlightedThumbImage:[UIImage imageNamed:@"thumb-highlighted"] minimumTrackImage:[UIImage imageNamed:@"track"]];
    [playerView setupFullScreenButtonWithImage:[UIImage imageNamed:@"full-screen"]];
    _playerView = playerView;
    
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    progressView.frame = CGRectMake(20, 500, 300, 10);
    progressView.progress = 0.3;
    progressView.progressTintColor = [UIColor yellowColor];
    progressView.trackTintColor = [UIColor grayColor];
    progressView.progressImage = [UIImage imageNamed:@"track"];
    [self.view addSubview:progressView];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 550, 100, 50)];
    [button1 setTitle:@"测试1" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor blueColor];
    [button1 addTarget:self action:@selector(button1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(250, 550, 100, 50)];
    [button2 setTitle:@"测试2" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor blueColor];
    [button2 addTarget:self action:@selector(button2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    [self.view addSubview:self.playerView];
}

- (void)button1Clicked:(UIButton *)button {
    [self presentViewController:[ViewController new] animated:YES completion:nil];
}

- (void)button2Clicked:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
