//
//  NewsContentModel.h
//  MyYiChat
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsContentModel : NSObject
@property(nonatomic,strong)NSString *data_type;
@property(nonatomic,strong)NSString *newsContent;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *width;
@property(nonatomic,strong)NSString *height;
+(id)creatNewsContentWith:(NSDictionary *)dic;
@end
