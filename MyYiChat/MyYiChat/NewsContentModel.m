//
//  NewsContentModel.m
//  MyYiChat
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "NewsContentModel.h"

@implementation NewsContentModel
+(id)creatNewsContentWith:(NSDictionary *)dic
{
    NewsContentModel *newsContent=[[NewsContentModel alloc]init];
    newsContent.data_type=[dic objectForKey:@"data_type"];
    if ([newsContent.data_type intValue]!=1) {

        NSDictionary *imageDic=[dic objectForKey:@"image"];
        newsContent.url=[imageDic objectForKey:@"source"];
        
        newsContent.width=[imageDic objectForKey:@"width"];
        newsContent.height=[imageDic objectForKey:@"height"];
    }else{
        newsContent.newsContent=[dic objectForKey:@"content"];
    }
    return newsContent;
}
@end
