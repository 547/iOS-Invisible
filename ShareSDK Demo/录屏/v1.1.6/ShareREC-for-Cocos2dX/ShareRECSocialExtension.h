//
//  ShareRecSocialExtension.h
//  ShareRecCocos2dXGameSample
//
//  Created by vimfung on 14-11-14.
//
//

#ifndef __ShareRecCocos2dXGameSample__ShareRecSocialExtension__
#define __ShareRecCocos2dXGameSample__ShareRecSocialExtension__

#include <iostream>
#include <map>
#include <string>
#include "ShareRECTypeDef.h"

namespace com
{
    namespace mob
    {
        /**
         *  ShareRec社区的Cocos2d-x扩展
         */
        class ShareRECSocialExtension
        {
        public:
            
            /**
             *  打开社区
             *
             *  @param title                分享的游戏标题
             *  @param userData             分享的用户数据
             *  @param pageType             跳转的社区页面类型
             *  @param listener             监听器
             *  @param closeHandler         关闭回调处理
             */
            static void Open(const char* title,
                             std::map<std::string, std::string> *userData,
                             SRSocialPageType pageType,
                             ShareRECListener *listener,
                             CloseHandler closeHandler);
        };
    }
}

#endif /* defined(__ShareRecCocos2dXGameSample__ShareRecSocialExtension__) */
