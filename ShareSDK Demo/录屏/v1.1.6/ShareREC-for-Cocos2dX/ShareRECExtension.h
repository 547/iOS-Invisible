//
//  ShareRecExtension.h
//  ShareRecCocos2dXGameSample
//
//  Created by vimfung on 14-11-13.
//
//

#ifndef __ShareRecCocos2dXGameSample__ShareRecExtension__
#define __ShareRecCocos2dXGameSample__ShareRecExtension__

#include <iostream>
#include <map>
#include <string>
#include "ShareRecTypeDef.h"

namespace com
{
    namespace mob
    {
        /**
         *  ShareRec的Cocos2d-x扩展
         */
        class ShareRECExtension
        {
        public:
            
            /**
             *  注册应用
             *
             *  @param appKey 应用标识
             */
            static void RegisterApp(const char *appKey);
            
            /**
             *  开始录像
             */
            static void StartRecording();
            
            /**
             *  结束录像
             *
             *  @param listener 监听器对象
             *  @param handler  完成事件
             */
            static void StopRecording(ShareRECListener *listener, RecordFinishedHandler handler);
            
            /**
             *  播放最后一个录像
             *
             */
            static void PlayLastRecording();
            
            /**
             *  设置码率，默认 800kbps = 800 * 1024
             *
             *  @param bitRate 码率
             */
            static void SetBitRate(int bitRate);
            
            /**
             *  设置帧率，默认30fps
             *
             *  @param fps 帧率
             */
            static void SetFPS(int fps);
            
            /**
             *  设置最短录制时间，默认4秒
             *
             *  @param time 时间（单位：秒），如果为0则表示不限制
             */
            static void SetMinimumRecordingTime(float time);
            
            /**
             *  获取最后一个录像路径
             *
             *  @return 录像路径
             */
            static const char* LastRecordingPath();
            
            /**
             *  编辑当前录像
             *
             *  @depricated                 v1.1.0后不推荐使用
             *
             *  @param title                分享标题
             *  @param userData             游戏数据
             *  @param listener             监听器
             *  @param closeHandler         关闭处理回调
             */
            static void EditLastRecording(const char *title,
                                          std::map<std::string, std::string> *userData,
                                          ShareRECListener *listener,
                                          CloseHandler closeHandler);
            
            /**
             *  编辑当前视频
             *
             *  @param listener      监听器
             *  @param resultHandler 返回处理回调
             */
            static void EditLastRecording(ShareRECListener *listener,
                                          EditResultHandler resultHandler);
            
            /**
             *  设置是否同步录制语音解说
             *
             *  @param flag true 同步录制， false 不录制
             */
            static void SetSyncAudioComment(bool flag);
        };
        
    }
}


#endif /* defined(__ShareRecCocos2dXGameSample__ShareRecExtension__) */
