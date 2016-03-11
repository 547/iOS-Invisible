//
//  ShareRecSocialExtensionIOS.cpp
//  ShareRecCocos2dXGameSample
//
//  Created by vimfung on 14-11-14.
//
//

#include "ShareRECSocialExtensionIOS.h"
#import <ShareRECSocial/ShareRECSocial.h>

using namespace com::mob;

void ShareRECSocialExtensionIOS::Open(const char *title,
                                      std::map<std::string, std::string> *userData,
                                      SRSocialPageType pageType,
                                      ShareRECListener *listener,
                                      CloseHandler closeHandler)
{
    NSString *titleStr = nil;
    NSMutableDictionary *userDataDict = nil;
    
    if (title != NULL)
    {
        titleStr = [NSString stringWithCString:title encoding:NSUTF8StringEncoding];
    }
    
    if (userData)
    {
        userDataDict = [NSMutableDictionary dictionary];
        
        std::map<std::string, std::string>::iterator  iter;
        for (iter = userData -> begin(); iter != userData -> end(); iter++)
        {
            const char* key = iter -> first.c_str();
            const char* value = iter -> second.c_str();
            if (key == NULL || value == NULL)
            {
                continue;
            }
            
            NSString *keyStr = [NSString stringWithCString:key encoding:NSUTF8StringEncoding];
            NSString *valueStr = [NSString stringWithCString:value encoding:NSUTF8StringEncoding];
            [userDataDict setObject:valueStr forKey:keyStr];
        }
    }
    
    [ShareRECSocial openByTitle:titleStr userData:userDataDict pageType:(ShareRECSocialPageType)pageType onClose:^{
        
        if (listener && closeHandler)
        {
            (listener ->* closeHandler) ();
        }
        
    }];
}
