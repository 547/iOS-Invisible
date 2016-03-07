//
//  ChatModel.h
//  MyYiChat
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject
@property(nonatomic,strong)NSString *chatContent;
@property(nonatomic,strong)NSString *friendName;
@property(nonatomic,strong)NSString *time;
+(id)createChatWithName:(NSString *)aName chatContent:(NSString *)aChatContent time:(NSString *)aTime;
@end
