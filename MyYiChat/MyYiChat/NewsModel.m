//
//  NewsModel.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
+(id)createNewwithId:(int)aId type:(int)aType channel:(NSString *)aChannel images:(NSMutableArray *)aImages news_title:(NSString *)aNew_title intro:(NSString *)aIntro source_url:(NSString *)aSource_url time:(NSString *)aTime source:(NSString *)aSource readTimes:(NSString *)aReadTimes auther:(NSString *)aAuther
{
    NewsModel *new=[[NewsModel alloc]init];
    new.Id=aId;
    new.type=aType;
    new.channel=aChannel;
    new.images=aImages;
    new.news_title=aNew_title;
    new.intro=aIntro;
    new.source_url=aSource_url;
    new.time=aTime;
    new.source=aSource;
    new.readtimes=aReadTimes;
    new.auther=aAuther;
    return new;
}
+(id)createNewsContent:(NSString *)aNew_title source:(NSString *)aSource auther:(NSString *)aAuther time:(NSString *)aTime intro:(NSString *)aIntro picArray:(NSMutableArray *)aPicArray contentArray:(NSMutableArray *)aContentArray commentDic:(NSDictionary *)aCommentDic
{
    NewsModel *new=[[NewsModel alloc]init];
    new.news_title=aNew_title;
    new.intro=aIntro;
    new.time=aTime;
    new.source=aSource;
    new.auther=aAuther;
    new.picArray=aPicArray;
    new.contentArray=aContentArray;
    new.commentDic=aCommentDic;
    return new;
}
@end
