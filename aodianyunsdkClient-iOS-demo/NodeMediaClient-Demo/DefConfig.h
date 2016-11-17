//
//  DefConfig.h
//  NodeMediaClient-Demo
//
//  Created by Mingliang Chen on 15/8/30.
//  Copyright (c) 2015年 NodeMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefConfig : NSObject
+(DefConfig*)sharedInstance;

-(void)putPlayUrl:(NSString*)playUrl;
-(void)putPublishUrl:(NSString*)publishUrl;
-(void)putBufferTime:(int)bufferTime;
-(void)putMaxBufferTime:(int)maxBufferTime;

-(NSString*)getPlayUrl;
-(NSString*)getPublishUrl;
-(int)getBufferTime;
-(int)getMaxBufferTime;
@end
