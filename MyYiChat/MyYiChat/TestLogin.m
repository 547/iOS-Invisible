//
//  TestLogin.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "TestLogin.h"

@implementation TestLogin
+(BOOL)isLogined
{
   NSString *access_token = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    NSDate *usefulTime=[[NSUserDefaults standardUserDefaults]objectForKey:@"usefulTime"];
    if (access_token!=nil) {
        
        if ([usefulTime compare:[NSDate date]]==NSOrderedSame||[usefulTime compare:[NSDate date]]==NSOrderedAscending) {
            //有效期大于等于当前时间
            return NO;
        }else{
        
            return YES;
        }
    }else{
    return NO;
    }
    
    
    
    
}

@end
