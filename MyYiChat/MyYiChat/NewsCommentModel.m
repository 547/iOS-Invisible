//
//  NewsCommentModel.m
//  MyYiChat
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "NewsCommentModel.h"

@implementation NewsCommentModel


+(id)createNewsCommentWithArray:(NSDictionary *)commentDic{
    NewsCommentModel *comm=[[NewsCommentModel alloc]init];
    comm.content=[commentDic objectForKey:@"info"];//帖子内容
    comm.author=[commentDic objectForKey:@"name"];//帖子作者
    return comm;
}

@end
