//
//  ShareRecExtension.cpp
//  ShareRecCocos2dXGameSample
//
//  Created by vimfung on 14-11-13.
//
//

#include "ShareRECExtension.h"
#include "ShareRECExtensionIOS.h"

#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS

//#include "C2DXiOSShareSDK.h"

#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID

//#include "ShareSDKUtils.h"

#endif

using namespace com::mob;

void ShareRECExtension::RegisterApp(const char *appKey)
{
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    
    ShareRECExtensionIOS::RegisterApp(appKey);
    
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    
    
#endif
}

void ShareRECExtension::StartRecording()
{
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    
    ShareRECExtensionIOS::StartRecording();
    
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    
    
#endif
}

void ShareRECExtension::StopRecording(ShareRECListener *listener, RecordFinishedHandler handler)
{
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    
    ShareRECExtensionIOS::StopRecording(listener, handler);
    
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    
    
#endif
}

void ShareRECExtension::PlayLastRecording()
{
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    
    ShareRECExtensionIOS::PlayLastRecording();
    
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    
    
#endif
}

void ShareRECExtension::SetBitRate(int bitRate)
{
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    
    ShareRECExtensionIOS::SetBitRate(bitRate);
    
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    
    
#endif
}

void ShareRECExtension::SetFPS(int fps)
{
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    
    ShareRECExtensionIOS::SetFPS(fps);
    
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    
    
#endif
}

void ShareRECExtension::SetMinimumRecordingTime(float time)
{
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    
    ShareRECExtensionIOS::SetMinimumRecordingTime(time);
    
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    
    
#endif
}

const char* ShareRECExtension::LastRecordingPath()
{
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    
    return ShareRECExtensionIOS::LastRecordingPath();
    
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    
    
#endif
    
    return NULL;
}

void ShareRECExtension::EditLastRecording(const char *title,
                                          std::map<std::string, std::string> *userData,
                                          ShareRECListener *listener,
                                          CloseHandler closeHandler)
{
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    
    ShareRECExtensionIOS::EditLastRecording(title, userData, listener, closeHandler);
    
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    
    
#endif
}

void ShareRECExtension::EditLastRecording(ShareRECListener *listener, EditResultHandler resultHandler)
{
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    
    ShareRECExtensionIOS::EditLastRecording(listener, resultHandler);
    
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    
    
#endif
}

void ShareRECExtension::SetSyncAudioComment(bool flag)
{
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    
    ShareRECExtensionIOS::SetSyncAudioComment(flag);
    
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    
    
#endif
}
