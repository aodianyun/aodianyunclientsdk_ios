//
//  NodePlayerViewController.m
//  NodeMediaClient-Demo
//
//  Created by Mingliang Chen on 16/8/17.
//  Copyright © 2016年 NodeMedia. All rights reserved.
//

#import "NodePlayerViewController.h"
#import "NodePlayer.h"

@interface NodePlayerViewController () <NodePlayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *playView1;
@property (weak, nonatomic) IBOutlet UIView *playView2;
@property (weak, nonatomic) IBOutlet UIView *playView3;

@property (nonatomic) NodePlayer *np1;
@property (nonatomic) NodePlayer *np2;
@property (nonatomic) NodePlayer *np3;
@end

@implementation NodePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //状态栏透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    //屏幕常亮
    [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ];
    
    _np1 = [[NodePlayer alloc] init];
    _np2 = [[NodePlayer alloc] init];
    _np3 = [[NodePlayer alloc] init];
    
    [_np1 setNodePlayerDelegate:self];
    [_np2 setNodePlayerDelegate:self];
    [_np3 setNodePlayerDelegate:self];

    _playView2.layer.zPosition = 1;
    _playView3.layer.zPosition = 1;
    
    [_np1 setUIView:_playView1 ContentMode:UIViewContentModeScaleAspectFit];
    [_np2 setUIView:_playView2 ContentMode:UIViewContentModeScaleAspectFit];
    [_np3 setUIView:_playView3 ContentMode:UIViewContentModeScaleAspectFit];
    
    [_np1 startPlay:@"rtmp://xyplay.nodemedia.cn/live/demo1"];
    [_np2 startPlay:@"rtmp://xyplay.nodemedia.cn/live/demo2"];
    [_np3 startPlay:@"rtmp://xyplay.nodemedia.cn/live/demo3"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    dispatch_async(dispatch_queue_create("close_dispatch",0), ^{
        if(_np1) {
            [_np1 stopPlay]; //停止播放,同步操作,所有线程退出后返回,有一定等待时间
            _np1 = nil;      //释放LivePlayer对象
        }
        
        if(_np2) {
            [_np2 stopPlay]; //停止播放,同步操作,所有线程退出后返回,有一定等待时间
            _np2 = nil;      //释放LivePlayer对象
        }
        
        if(_np3) {
            [_np3 stopPlay]; //停止播放,同步操作,所有线程退出后返回,有一定等待时间
            _np3 = nil;      //释放LivePlayer对象
        }
    });
    
}


-(void) onEventCallback:(id)sender event:(int)event msg:(NSString *)msg {
    if([_np1 isEqual:sender]) {
        NSLog(@"np1 onEventCallback:%d %@",event,msg);
    } else if([_np2 isEqual:sender]) {
        NSLog(@"np2 onEventCallback:%d %@",event,msg);
    } else if([_np3 isEqual:sender]) {
        NSLog(@"np3 onEventCallback:%d %@",event,msg);
    }
}

@end
