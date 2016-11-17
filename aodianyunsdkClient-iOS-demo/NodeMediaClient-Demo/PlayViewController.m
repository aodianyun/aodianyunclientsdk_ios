//
//  PlayViewController.m
//  NodeMediaClient-Demo
//
//  Created by Mingliang Chen on 15/8/25.
//  Copyright (c) 2015年 NodeMedia. All rights reserved.
//

#import "PlayViewController.h"
#import "LivePlayer.h"
#import "DefConfig.h"

@interface PlayViewController()<LivePlayerDelegate>

@property (weak, nonatomic) IBOutlet UIView *playVideoView;
@property (nonatomic) LivePlayer *lp;

@end

@implementation PlayViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //状态栏透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    //屏幕常亮
    [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ];
    
    
    _lp = [[LivePlayer alloc] init]; //1.alloc and init
    [_lp setLivePlayerDelegate:self];//2.设置事件Delegate
    
    /**
     * 3.设置播放UIView
     *   如果uiview传入nil,则不解码播放视频,作为纯音频播放模式
     *   画面填充模式,当前支持下面三种现实模式，他们的差别是 
     *   当uiview高宽比与视频高宽比不同时                视频画面是否铺满uiview |画面是否变形|有无黑边|视频画面是否会被裁剪
     *   拉伸填充 UIViewContentModeScaleToFill           是               |   是      |  无   | 否
     *   等比缩放 UIViewContentModeScaleAspectFit        否               |   否      |  有   | 否
     *   等比缩放填充 UIViewContentModeScaleAspectFill    是               |   否      |  无   | 是
     */
    [_lp setUIView:_playVideoView ContentMode:UIViewContentModeScaleAspectFill];
    
    
    //4.设置启动缓冲时长 单位毫秒,此参数关系视频流连接成功开始获取数据后缓冲多少毫秒后开始播放
    [_lp setBufferTime:[[DefConfig sharedInstance] getBufferTime]];
    
    //4.设置最大缓冲时长 单位毫秒,此参数关系视频最大缓冲时长.RTMP基于TCP协议不丢包,网络抖动且缓冲区播完,之后仍然会接受到抖动期的过期数据包.
    //设置此参数,可以加快播放超出的部分,追上直播发布者的时间线
    [_lp setMaxBufferTime:[[DefConfig sharedInstance] getMaxBufferTime]];
    
    //5.设置是否接收音视频流  参考 rtmp_specification_1.0.pdf 7.2.2.4. & 7.2.2.5.
    //默认都为true 如不需要可以不设置该值
    //注意： 目前测试了fms和red5支持该参数设定有效，欢迎测试补充
//    _lp.receiveAudio = true;
//    _lp.receiveVideo = false;
    
    /**
     * 5.当设为true时，向服务端发送FCSubscribe命令，默认不发送
     * When streaming RTMP live streams using the Akamai, Edgecast or Limelight CDN,
     * players cannot simply connect to the live stream. Instead, they have to subscribe to it,
     * by sending a so-called FC Subscribe call to the server.
     */
//    _lp.subscribe = true;
    
    
    //6.开始播放 异步操作,调用后即返回,播放状态由LivePlayerDelegate回调.
    [_lp startPlay:[[DefConfig sharedInstance] getPlayUrl]];

    
//    // 每200毫秒获取一次bufferLength做缓冲调试
//    dispatch_async(dispatch_queue_create("buffer_length_dispatch",DISPATCH_QUEUE_SERIAL), ^{
//        while(_lp != nil) {
//            NSLog(@"BufferLength:%d",[_lp getBufferLength]);
//            usleep(200000);
//        }
//    });
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    dispatch_async(dispatch_queue_create("close_dispatch",0), ^{
        if(_lp) {
            [_lp stopPlay]; //停止播放,同步操作,所有线程退出后返回,有一定等待时间
            _lp = nil;      //释放LivePlayer对象
        }
    });
    
}

- (IBAction)capAction:(id)sender {
    //截取当前视频图 存储到应用程序沙箱目录 在视频开始播放后即可调用,视频播放结束后无法使用
    static int count = 0;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *fileName = [NSString stringWithFormat:@"play_cap_%d.jpg", count++];
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    BOOL ret = [_lp capturePicture:filePath];
    NSLog(@"LivePlayer capture picture to %@ [%@]",filePath,ret?@"YES":@"NO");
}

-(void) onEventCallback:(int)event msg:(NSString *)msg {
    NSLog(@"onEventCallback:%d %@",event,msg);
    switch (event) {
        case 1000:
            //开始连接播放流
            break;
        case 1001:
            //播放流连接成功
            break;
        case 1002:
            //播放流连接失败
            break;
        case 1003:
            //播放流连接失败或播放过程中网络异常断开,进入自动重连
//            [_lp stopPlay];
            break;
        case 1004:
            //播放停止 所有资源处于可释放状态.
            break;
        case 1005:
            //播放中遇到网络异常
//            [_lp stopPlay];
            break;
        case 1100:
            //NetStream.Buffer.Empty        数据缓冲为空 播放停止
            break;
        case 1101:
            //NetStream.Buffer.Buffering    开始缓冲数据
            break;
        case 1102:
            //NetStream.Buffer.Full         数据缓冲足够 开始播放
            break;
        case 1103:
            //收到 Stream EOF 或者 NetStream.Play.UnpublishNotify
//            [_lp stopPlay];
            break;
        default:
            break;
    }
    
}

@end
