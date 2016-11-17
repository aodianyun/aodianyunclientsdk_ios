//
//  NodeStreamer.h
//  NodeMediaClient v1.2.12
//
//  Created by Mingliang Chen on 16/9/8.
//  Copyright © 2016年 NodeMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NodeStreamerDelegate

-(void) onEventCallback:(id)sender event:(int)event msg:(NSString*)msg;

@end

@interface NodeStreamer : NSObject

@property (nonatomic, weak) id<NodeStreamerDelegate> nodeStreamerDelegate;
-(int) startNativeRateStreaming:(NSString*)inputUrl output:(NSString*)outputUrl;
-(int) startStreamingWithInput:(NSString*)inputUrl output:(NSString*)outputUrl;
-(int) stopStreaming;

@end
