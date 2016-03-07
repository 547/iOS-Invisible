//
//  MyJson.h
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"
#import "PersonModel.h"
#import "ChatModel.h"
#import "FileModel.h"
@interface MyJson : NSObject
@property (nonatomic,retain)NSMutableArray *newsArray;
+(NSMutableArray *)getPublicFileMessage:(NSDictionary *)dic;
+(BOOL)sentChatMessage:(NSDictionary *)dic;
+(BOOL)loginJson:(NSDictionary *)dic;
+(NSMutableArray *)newsJson:(NSDictionary *)dic;
+(NewsModel *)newsJson:(NSDictionary *)dic news:(NewsModel *)news;
+(NSMutableArray *)getNewsContentJson:(NSDictionary *)dic;
+(PersonModel *)getPerson:(NSDictionary *)dic;
+(BOOL)uploadHeaderImage:(NSDictionary *)dic;
+(BOOL)tuiChuJson:(NSDictionary *)dic;
+(BOOL)changeMessage:(NSDictionary *)dic;
+(NSMutableArray *)getPersonArray:(NSDictionary *)dic;
+(void)getChatMessage:(NSDictionary *)dic;
+(NSMutableArray *)getPersonFileMessage:(NSDictionary *)dic;
@end
