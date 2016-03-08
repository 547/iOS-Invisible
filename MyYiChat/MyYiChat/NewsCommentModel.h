//
//  NewsCommentModel.h
//  MyYiChat
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsCommentModel : NSObject
@property(nonatomic,strong)NSString *author;//评论作者
@property(nonatomic,strong)NSString *content;//评论正文

+(id)createNewsCommentWithArray:(NSDictionary *)commentDic;
@end
