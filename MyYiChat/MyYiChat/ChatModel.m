//
//  ChatModel.m
//  MyYiChat
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel
+(id)createChatWithName:(NSString *)aName chatContent:(NSString *)aChatContent time:(NSString *)aTime
{
    ChatModel *chat=[[ChatModel alloc]init];
    chat.friendName=aName;
    chat.time=aTime;
    chat.chatContent=aChatContent;
    return chat;
}
@end
