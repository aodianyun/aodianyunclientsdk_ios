#NodeMediaClient-iOS

##简介
NodeMediaClient是为移动端应用量身打造的基于RTMP协议的流媒体直播系统。通过集成本SDK，只需几个简单API调用，便可实现一套完整的直播流媒体应用基础。包含了流媒体应用中：『采集->编码->传输->解码->播放』的所有步骤。

##编译环境
**xcode** 7以上

##支持的系统平台
**iOS** 7.0及以上

##支持的CPU架构
**iOS** armv7 armv7s arm64 i386 x86_64  

##支持的流媒体服务端
fms, wowza, evostream, red5, crtmpserver, nginx-rtmp-module, srs, Node-Media-Server及其他标准RTMP协议服务端

##支持的流媒体云服务器
[奥点云](http://www.aodianyun.com/)及其他标准RTMP协议云服务器

##直播发布特性
* H.264/AAC 组合的RTMP协议音视频流发布
* 全屏视频采集，720p原画质缩放
* NEON指令集优化H.264软件编码器，性能强劲，兼容性极强
* H.264支持Baseline, Main, High profile
* iOS8以上支持视频硬编码
* 支持手机旋转,横屏16:9，竖屏9:16分辨率自动输出横竖屏视频流
* NEON优化AAC软件编码器，极少CPU占用，支持LC和HE profile，音质还原效果好
* 支持环境背景噪音抑制，不再有沙沙声
* 支持发布中途切换前后摄像头
* 支持闪光灯开关
* 支持全时自动对焦与手动对焦切换
* 支持单音频流发布
* 支持发布中途来电保持网络流，暂停发布，挂机后继续发布
* 支持预览摄像头后,任意时刻截图
* 支持定义为'live','record','append'的发布类型
* 支持Adobe auth模式的鉴权验证 如rtmp://user:pass@server:port/app/name
* 内置基于GPU加速的5级磨皮美白滤镜
* 支持动态设置视频码率
* 支持视频码率自适应网络带宽

##直播播放特性
* 只为RTMP协议优化的码流解析器，极短的分析时间，秒开RTMP视频流
* NEON指令集优化的软件解码器，性能好，兼容性强
* 支持的网络协议 RTMP/RTMPT/RTSP/HLS/HTTP-FLV
* 支持的视频解码器:H.264, FLV, VP6, MPEG4
* 支持的音频解码器:AAC, MP3, SPEEX, NELLYMOSER, ADPCM_SWF, G.711
* OpenGL ES视频渲染
* 全自动网络异常重连
* 支持播放中途来电保持网络流，暂停播放，挂机后继续播放
* 支持播放中途任意时刻截图
* 支持设置最大缓冲时长,杜绝延迟累计
* 支持播放前设置receiveAudio,receiveVideo来控制只接收音频或视频流(需服务端实现，fms，red5支持)
* 支持发送FCSubscribe命令，兼容国外Akamai, Edgecast , Limelight 等CDN
* 支持主播停止推流后，播放端立即获取到结束状态（RTMP协议下）
* 支持多路直播流同时播放

##直播串流器
v1.2.2新增NodeStreamer类,可用于户外环境下,具有RTSP协议的运动相机/无人机连接手机热点,通过手机4G网络串流到RTMP服务器.  
手机端不进行编解码,只有网络IO,不占用CPU.注:当按Home或锁屏时,系统会禁止后台网络传输,该功能目前在iOS上太实用,只为了与[Android端](https://github.com/NodeMedia/NodeMediaClient-Android)功能保持一致.

##双向音视频？
支持一个页面内同时发布视频和播放视频，但由于有回音问题，建议这种应用使用耳机，后期的版本会考虑回音消除

##ipv6
苹果2016年6月新政策规定新上架app必须支持ipv6-only。经过验证，我们已发布的版本均支持ipv6地址或解析到ipv6地址的域名进行直播。可使用<s>下面的地址验证，（注：需要测试环境具有公网ipv6环境）</s> 已失效,请自行搭建监听IPV6地址的Nginx-Rtmp测试
 * <s>rtmp://[lssv6.nodemedia.cn]/live/demo</s>
 * <s>rtmp://[2001:19f0:7000:80b5:5400:00ff:fe27:3f9b]/live/demo</s>

## v1.x 版本主要开发计划
 * 实时美颜发布
 * 4:3分辨率发布
 * 多播
 * 硬件编解码
 * 新增实现：用于1对1音视频的开发类，包含回音消除
 * 新增实现：用于点播的类
 * 发布端更多滤镜特效,大眼,瘦脸

##商用授权
程序发布需商用授权，业务咨询请联系  
QQ:281269007  
Email:service@nodemedia.cn
