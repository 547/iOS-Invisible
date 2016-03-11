//
//  ShareRecSocialExtension.cpp
//  ShareRecCocos2dXGameSample
//
//  Created by vimfung on 14-11-14.
//
//

#include "ShareRECSocialExtension.h"
#include "ShareRECSocialExtensionIOS.h"

using namespace com::mob;

void ShareRECSocialExtension::Open(const char *title,
                                   std::map<std::string, std::string> *userData,
                                   SRSocialPageType pageType,
                                   ShareRECListener *listener,
                                   CloseHandler closeHandler)
{
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    
    ShareRECSocialExtensionIOS::Open(title, userData, pageType, listener, closeHandler);
    
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    
    
#endif
}