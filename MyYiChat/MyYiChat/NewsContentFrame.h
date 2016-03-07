//
//  NewsContentFrame.h
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"
#import <UIKit/UIKit.h>


@interface NewsContentFrame : NSObject

@property(nonatomic,strong)NewsModel *news;
@property(nonatomic,assign)CGRect titleFrame;
@property(nonatomic,assign)CGRect sourceFrame;
@property(nonatomic,assign)CGRect authorFrame;
@property(nonatomic,assign)CGRect timeFrame;
@property(nonatomic,assign)CGRect infoViewFrame;
@property(nonatomic,assign)CGRect infoFrame;
@property(nonatomic,assign)CGRect contentFrame;
@property(nonatomic,assign)CGRect picFrame;
@property(nonatomic,assign)CGRect commentTitleFrame;
@property(nonatomic,assign)CGRect commentAuthorFrame;
@property(nonatomic,assign)CGRect commentContentFraame;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *picArray;
@property(nonatomic,strong)NSMutableArray *commentAuthorArray;
@property(nonatomic,strong)NSMutableArray *commentContentArray;
@property(nonatomic,assign)CGFloat cellHeight;

@end
