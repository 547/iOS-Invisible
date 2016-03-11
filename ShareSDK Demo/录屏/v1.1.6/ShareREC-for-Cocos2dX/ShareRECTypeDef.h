//
//  ShareRecTypeDef.h
//  ShareRecCocos2dXGameSample
//
//  Created by vimfung on 14-11-14.
//
//

#ifndef ShareRecCocos2dXGameSample_ShareRecTypeDef_h
#define ShareRecCocos2dXGameSample_ShareRecTypeDef_h

#include "ShareRECListener.h"

namespace com
{
    namespace mob
    {
        /**
         *  录像完成回调处理
         */
        typedef void(ShareRECListener::*RecordFinishedHandler) (bool error);
        
        /**
         *  关闭回调处理
         */
        typedef void(ShareRECListener::*CloseHandler) ();
        
        /**
         *  编辑返回处理
         */
        typedef void(ShareRECListener::*EditResultHandler) (bool cancelled);
        
        /**
         ShareRec社区页面类型
         */
        typedef enum
        {
            SRSocialPageTypeShare = 0,            //分享页
            SRSocialPageTypeVideoCenter = 1,      //视频中心
            SRSocialPageTypeProfile = 2           //个人中心
        }
        SRSocialPageType;
    }
}

#endif
