//
//  MainViewController.m
//  NodeMediaClient-Demo
//
//  Created by Mingliang Chen on 15/8/30.
//  Copyright (c) 2015年 NodeMedia. All rights reserved.
//

#import "MainViewController.h"
#import "DefConfig.h"

@interface MainViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *playUrl;
@property (weak, nonatomic) IBOutlet UITextField *publishUrl;
@property (weak, nonatomic) IBOutlet UITextField *bufferTime;
@property (weak, nonatomic) IBOutlet UITextField *maxBufferTime;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_playUrl setDelegate:self];
    [_publishUrl setDelegate:self];
    [_bufferTime setDelegate:self];
    [_maxBufferTime setDelegate:self];
    
    NSString *playUrl = [[DefConfig sharedInstance] getPlayUrl];
    if(playUrl != nil) {
        _playUrl.text =playUrl;
    }
    
    NSString *publishUrl = [[DefConfig sharedInstance] getPublishUrl];
    if(publishUrl != nil) {
        _publishUrl.text = publishUrl;
    }
    
    int bt = [[DefConfig sharedInstance] getBufferTime];
    if(bt > 0) {
        _bufferTime.text = [NSString stringWithFormat:@"%d",bt];
    }
    
    int mbt = [[DefConfig sharedInstance] getMaxBufferTime];
    if(mbt > 0) {
        _maxBufferTime.text = [NSString stringWithFormat:@"%d",mbt];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[DefConfig sharedInstance] putPlayUrl:_playUrl.text];
    [[DefConfig sharedInstance] putPublishUrl:_publishUrl.text];
    [[DefConfig sharedInstance] putBufferTime:[_bufferTime.text intValue]];
    [[DefConfig sharedInstance] putMaxBufferTime:[_maxBufferTime.text intValue]];
}
@end
