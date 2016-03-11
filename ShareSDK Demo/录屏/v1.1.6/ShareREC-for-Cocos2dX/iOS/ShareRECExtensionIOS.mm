//
//  ShareRecExtensionIOS.m
//  ShareRecCocos2dXGameSample
//
//  Created by vimfung on 14-11-13.
//
//

#import "ShareRECExtensionIOS.h"
#import <ShareREC/ShareREC.h>
#import <ShareREC/Extention/ShareREC+Ext.h>

using namespace com::mob;

void ShareRECExtensionIOS::RegisterApp(const char *appKey)
{
    NSString *appKeyStr = nil;
    if (appKey != NULL)
    {
        appKeyStr = [NSString stringWithCString:appKey encoding:NSUTF8StringEncoding];
    }
    
    [ShareREC registerApp:appKeyStr];
}

void ShareRECExtensionIOS::StartRecording()
{
    [ShareREC startRecording];
}

void ShareRECExtensionIOS::StopRecording(ShareRECListener *listener, RecordFinishedHandler handler)
{
    [ShareREC stopRecording:^(NSError *error) {
       
        if (listener && handler)
        {
            (listener ->* handler)(error ? true : false);
        }
        
    }];
}

void ShareRECExtensionIOS::PlayLastRecording()
{
    [ShareREC playLastRecording];
}

void ShareRECExtensionIOS::SetBitRate(int bitRate)
{
    [ShareREC setBitRate:bitRate];
}

void ShareRECExtensionIOS::SetFPS(int fps)
{
    [ShareREC setFPS:fps];
}

void ShareRECExtensionIOS::SetMinimumRecordingTime(float time)
{
    [ShareREC setMinimumRecordingTime:time];
}

const char* ShareRECExtensionIOS::LastRecordingPath()
{
    return [[ShareREC lastRecordingPath] UTF8String];
}

void ShareRECExtensionIOS::EditLastRecording(const char *title,
                       std::map<std::string, std::string> *userData,
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
    
    [ShareREC editLastRecordingWithTitle:titleStr userData:userDataDict onClose:^{
        
        if (listener && closeHandler)
        {
            (listener ->* closeHandler) ();
        }
        
    }];
}

void ShareRECExtensionIOS::EditLastRecording(ShareRECListener *listener,
                                             EditResultHandler resultHandler)
{
    [ShareREC editLastRecording:^(BOOL cancelled) {
       
        if (listener && resultHandler)
        {
            (listener ->* resultHandler) (cancelled ? true : false);
        }
        
    }];
}

void ShareRECExtensionIOS::SetSyncAudioComment(bool flag)
{
    [ShareREC setSyncAudioComment:flag ? YES : NO];
}

