//
//  NewsContentFrame.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "NewsContentFrame.h"
#define SpacingOfLine 15//间距
#define SPACINGMINI 10
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width//屏幕宽
#define CONTENTFONT [UIFont systemFontOfSize:20]
#define TITLEFONT [UIFont systemFontOfSize:25]
#define TIMEFONT [UIFont systemFontOfSize:12]
@implementation NewsContentFrame
-(void)setNews:(NewsModel *)news
{//重写Set方法
    _news=news;
    
    //设置新闻标题的尺寸
    CGFloat titleX=SpacingOfLine;
    CGFloat titleY=SpacingOfLine;
    CGSize titleSiez=[news.news_title sizeWithFont:TITLEFONT constrainedToSize:CGSizeMake(SCREENWIDTH-2*SpacingOfLine, MAXFLOAT)];
    _titleFrame=(CGRect){{titleX,titleY},titleSiez};
    
    //设置来源的尺寸
    CGFloat sourceX=titleX;
    CGFloat sourceY=CGRectGetMaxY(_titleFrame)+SPACINGMINI;
    CGSize sourceSize=[news.source sizeWithFont:TIMEFONT];
    _sourceFrame=(CGRect){{sourceX,sourceY},sourceSize};
    
    //设置作者chicun
    CGFloat authorX=CGRectGetMaxX(_sourceFrame)+SPACINGMINI;
    CGFloat authorY=sourceY;
    CGSize authorSize=[news.auther sizeWithFont:TIMEFONT];
    _authorFrame=(CGRect){{authorX,authorY},authorSize};
    
    //设置时间的Frame
    CGFloat timeX=CGRectGetMaxX(_authorFrame)+SpacingOfLine;
    CGFloat timeY=sourceY;
    CGSize timeSize=[news.time sizeWithFont:TIMEFONT];
    _titleFrame=(CGRect){{timeX,timeY},timeSize};
    
    //设置摘要视图的Frame
    CGFloat infoViewX=0;
    CGFloat infoViewY=CGRectGetMaxY(_sourceFrame)+SpacingOfLine;
    //设置摘要的Frame
    CGFloat infoX=titleX;
    CGFloat infoY=titleY;
    CGSize infoSize=[news.intro sizeWithFont:CONTENTFONT constrainedToSize:CGSizeMake(SCREENWIDTH-2*SpacingOfLine, MAXFLOAT)];
    _infoFrame=(CGRect){{infoX,infoY},infoSize};
    CGFloat infoViewWidth=SCREENWIDTH;
    CGFloat infoViewHeight=infoSize.height+2*SPACINGMINI;
    _infoViewFrame=CGRectMake(infoViewX, infoViewY, infoViewWidth, infoViewHeight);
    _contentArray=[[NSMutableArray alloc]init];
    if (news.contentArray.count>0) {
        //有正文有配图
        
        static CGFloat conntentHeight=0;
        for (int i=0; i<news.contentArray.count; i++) {
            
            NSString *content=news.contentArray[i];
            CGFloat contentX=titleX;
            CGFloat contentY=CGRectGetMaxY(_infoViewFrame)+SpacingOfLine+conntentHeight;
            CGSize contentSize=[content sizeWithFont:CONTENTFONT constrainedToSize:CGSizeMake(SCREENWIDTH-2*SpacingOfLine, MAXFLOAT)];
            CGRect contentFrame10=(CGRect){{contentX,contentY},contentSize};
            //将结构体存到数组的方法
            NSValue *value10=nil;
            value10=[NSValue valueWithBytes:&contentFrame10 objCType:@encode(CGRect)];
            [_contentArray addObject:value10];
            conntentHeight=CGRectGetMaxY(contentFrame10)+SpacingOfLine;
            
        }//for循环
        
        static CGFloat heightAgo=0;
        if (news.picArray.count>0) {
            //有配图
            for (int j=0; j<news.picArray.count; j++) {
                _picArray=[[NSMutableArray alloc]init];
                NSDictionary *picDic=news.picArray[j];
                NSString *wid = [picDic objectForKey:@"width"];
                NSString *hei=[picDic objectForKey:@"height"];
                CGFloat picWidth=[wid floatValue];
                CGFloat picHeight=[hei floatValue];
                CGFloat picX=SPACINGMINI;
                CGFloat picY=0;
                if (j>0) {
                    picY=CGRectGetMaxY(_infoViewFrame)+SpacingOfLine*(j+1)+heightAgo;
                } else {
                    picY=CGRectGetMaxY(_infoViewFrame)+SpacingOfLine;
                }
                CGRect pic20=CGRectMake(picX, picY, picWidth, picHeight);
                NSValue *value20=nil;
                value20=[NSValue valueWithBytes:&pic20 objCType:@encode(CGRect)];
                [_picArray addObject:value20];
                heightAgo=picHeight;
            }//图片for循环
            
            
            
            
        } else {
            //有正文无配图
            static CGFloat conntentHeight=0;
            for (int i=0; i<news.contentArray.count; i++) {
                
                NSString *content=news.contentArray[i];
                CGFloat contentX=titleX;
                CGFloat contentY=CGRectGetMaxY(_infoViewFrame)+SpacingOfLine+conntentHeight;
                CGSize contentSize=[content sizeWithFont:CONTENTFONT constrainedToSize:CGSizeMake(SCREENWIDTH-2*SpacingOfLine, MAXFLOAT)];
                CGRect contentFrame10=(CGRect){{contentX,contentY},contentSize};
                //将结构体存到数组的方法
                NSValue *value10=nil;
                value10=[NSValue valueWithBytes:&contentFrame10 objCType:@encode(CGRect)];
                [_contentArray addObject:value10];
                conntentHeight=CGRectGetMaxY(contentFrame10)+SpacingOfLine;
                
            }//for循环
            //设置热门跟帖Frame==有正文无配图
            CGRect content20;
            [[_picArray lastObject]getValue:&content20];
            CGFloat commentTitleX=titleX;
            CGFloat commentTitleY=CGRectGetMaxY(content20)+SpacingOfLine;
            NSString *str=@"热门跟帖";
            CGSize commenttitleSize=[str sizeWithFont:TITLEFONT];
            _commentTitleFrame=(CGRect){{commentTitleX,commentTitleY},commenttitleSize};
            
            
            
            
        }

       
        
        
        
    } else {
        //无正文有配图
        static CGFloat heightAgo=0;
        if (news.picArray.count>0) {
            //有配图
            for (int j=0; j<news.picArray.count; j++) {
                _picArray=[[NSMutableArray alloc]init];
                NSDictionary *picDic=news.picArray[j];
                NSString *wid = [picDic objectForKey:@"width"];
                NSString *hei=[picDic objectForKey:@"height"];
                CGFloat picWidth=[wid floatValue];
                CGFloat picHeight=[hei floatValue];
                CGFloat picX=SPACINGMINI;
                CGFloat picY=0;
                if (j>0) {
                    picY=CGRectGetMaxY(_infoViewFrame)+SpacingOfLine*(j+1)+heightAgo;
                } else {
                    picY=CGRectGetMaxY(_infoViewFrame)+SpacingOfLine;
                }
                CGRect pic20=CGRectMake(picX, picY, picWidth, picHeight);
                NSValue *value20=nil;
                value20=[NSValue valueWithBytes:&pic20 objCType:@encode(CGRect)];
                [_picArray addObject:value20];
                heightAgo=picHeight;
            }//图片for循环
            
            //设置热门跟帖Frame==无正文有配图
            CGRect pic21;
            [[_picArray lastObject]getValue:&pic21];
            CGFloat commentTitleX=titleX;
            CGFloat commentTitleY=CGRectGetMaxY(pic21)+SpacingOfLine;
            NSString *str=@"热门跟帖";
            CGSize commenttitleSize=[str sizeWithFont:TITLEFONT];
            _commentTitleFrame=(CGRect){{commentTitleX,commentTitleY},commenttitleSize};
            
        } else {
            //无配图无正文
            //设置热门跟帖Frame
            CGFloat commentTitleX=titleX;
            CGFloat commentTitleY=CGRectGetMaxY(_infoViewFrame)+SpacingOfLine;
            NSString *str=@"热门跟帖";
            CGSize commenttitleSize=[str sizeWithFont:TITLEFONT];
            _commentTitleFrame=(CGRect){{commentTitleX,commentTitleY},commenttitleSize};
            
        }
    }//没有正文
    //设置帖子
    
    if (news.commentDic.count>0) {
        //有帖子
        NSArray *auArray=news.commentDic.allKeys;
        NSArray *contentArray=news.commentDic.allValues;
        static CGFloat commtenHeight=0;
        _commentContentArray=[[NSMutableArray alloc]init];
        _commentAuthorArray=[[NSMutableArray alloc]init];
        for (int n=0; n<auArray.count; n++) {
            NSString *au=auArray[n];
            NSString *conten=contentArray[n];
            //作者
            CGFloat auX=titleX;
            CGFloat auY=CGRectGetMaxY(_commentTitleFrame)+2*SpacingOfLine+commtenHeight;
            CGSize auSize=[au sizeWithFont:TITLEFONT];
            CGRect auFrame=(CGRect){{auX,auY},auSize};
            NSValue *valueAu=nil;
            valueAu=[NSValue valueWithBytes:&auFrame objCType:@encode(CGRect)];
            [_commentAuthorArray addObject:valueAu];
            
            //帖子正文
            CGFloat contenX=titleX;
            CGFloat contenY=CGRectGetMaxY(auFrame)+SPACINGMINI;
            CGSize contenSiez=[conten sizeWithFont:CONTENTFONT constrainedToSize:CGSizeMake(SCREENWIDTH-2*SpacingOfLine, MAXFLOAT)];
            CGRect contenFrame=(CGRect){{contenX,contenY},contenSiez};
            NSValue *valueCon=nil;
            [NSValue valueWithBytes:&contenFrame objCType:@encode(CGRect)];
            [_commentContentArray addObject:valueCon];
            commtenHeight=CGRectGetMaxY(contenFrame)+SpacingOfLine;
            
            
        }
        CGRect comment;
        [[_commentContentArray lastObject]getValue:&comment];
        _cellHeight=CGRectGetMaxY(comment)+SpacingOfLine;
        
    } else {
        //无帖子
        _cellHeight=CGRectGetMaxY(_infoViewFrame)+SpacingOfLine;
    }//无帖子
    
}


@end
