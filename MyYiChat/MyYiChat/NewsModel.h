//
//  NewsModel.h
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property(nonatomic,strong)NSString *info;
@property(nonatomic,assign)int pages;
@property(nonatomic,assign)int currentpage;
@property(nonatomic,assign)int Id;
@property(nonatomic,assign)int type;//1.互联网 2.科技 3.社会 4.娱乐5.体育6.图片
@property(nonatomic,strong)NSString *channel;//新闻类型的描述
@property(nonatomic,strong)NSMutableArray *images;
@property(nonatomic,assign)int width;
@property(nonatomic,assign)int height;
@property(nonatomic,strong)NSString *url;//图片相对路径
@property(nonatomic,strong)NSString *news_title;//新闻标题
@property(nonatomic,strong)NSString *intro;//新闻简介
@property(nonatomic,strong)NSString *source_url;//新闻访问相对路径
@property(nonatomic,strong)NSString *time;//发布时间
@property(nonatomic,strong)NSString *source;//新闻来源
@property(nonatomic,strong)NSString *readtimes;//被阅读次数
@property(nonatomic,strong)NSString *auther;//作者
@property(nonatomic,strong)NSMutableArray *contentArray;//正文数组=文字+图片
@property(nonatomic,strong)NSMutableArray *picArray;
@property(nonatomic,strong)NSDictionary *commentDic;
@property(nonatomic,strong)NSMutableArray *commentArray;//评论数组
+(id)createNewwithId:(int)aId type:(int)aType channel:(NSString *)aChannel images:(NSMutableArray *)aImages news_title:(NSString *)aNew_title intro:(NSString *)aIntro source_url:(NSString *)aSource_url time:(NSString *)aTime source:(NSString *)aSource readTimes:(NSString *)aReadTimes auther:(NSString *)aAuther;
+(id)createNewsContent:(NSString *)aNew_title source:(NSString *)aSource auther:(NSString *)aAuther time:(NSString *)aTime intro:(NSString *)aIntro picArray:(NSMutableArray *)aPicArray contentArray:(NSMutableArray *)aContentArray commentDic:(NSDictionary *)aCommentDic;
@end
