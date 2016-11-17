//
//  NodeStreamerViewController.m
//  NodeMediaClient-Demo
//
//  Created by Mingliang Chen on 16/9/8.
//  Copyright © 2016年 NodeMedia. All rights reserved.
//

#import "NodeStreamerViewController.h"
#include "NodeStreamer.h"



@interface NodeStreamerViewController ()<NodeStreamerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UITextField *outputTF;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (nonatomic) NodeStreamer *ns;
@property (nonatomic) Boolean isStarting;
@end

@implementation NodeStreamerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ns = [[NodeStreamer alloc] init];
    [_ns setNodeStreamerDelegate:self];
    _isStarting = false;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startStreamingAct:(id)sender {
    if(_isStarting) {
        [_ns stopStreaming];
    }else {
        [_ns startStreamingWithInput:_inputTF.text output:_outputTF.text];
        
    }
}

-(void) onEventCallback:(id)sender event:(int)event msg:(NSString *)msg {
    NSLog(@"[NodeStreamer] event:%d msg:%@",event,msg);
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (event) {
            case 3000:
                //串流器开始打开输入地址
                break;
            case 3001:
                //串流器输入地址打开成功
                //串流器开始打开输出地址
                break;
            case 3002:
                //串流器输出地址打开成功,开始串流
                _isStarting = true;
                [_startBtn setTitle:@"STOP" forState:UIControlStateNormal];
                break;
            case 3003:
                //串流器输入端打开失败
                break;
            case 3004:
                //串流器输出端打开失败
                break;
            case 3005:
                //串流中途网络异常中断
                break;
            case 3006:
                //串流结束
                _isStarting = false;
                [_startBtn setTitle:@"STREAMING" forState:UIControlStateNormal];
                break;
            case 3007:
                //输入流码率,单位kBps  100.00|32.00|68.00
                //分别代表,总码率|音频码率|视频码率
                
                break;
            default:
                break;
        }
    });
    
}


@end
