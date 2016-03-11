//
//  MyJson.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MyJson.h"

@implementation MyJson
+(BOOL)loginJson:(NSDictionary *)dic
{
    NSString *result=[dic objectForKey:@"result"];
    if ([result intValue]==1) {
        NSString *access_token=[dic objectForKey:@"access_token"];
        NSString *time=[dic objectForKey:@"time"];
        NSDate *usefulTime=[NSDate dateWithTimeIntervalSinceNow:[time intValue]];
        [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"result"];
        [[NSUserDefaults standardUserDefaults]setObject:access_token forKey:@"access_token"];
        [[NSUserDefaults standardUserDefaults]setObject:usefulTime forKey:@"usefulTime"];
        return YES;
        
    }else
    {
        return NO;
    }
    
}
//#pragma mask==数组的懒加载
//-(NSMutableArray *)newsArray
//{
//    if (!_newsArray) {
//        _newsArray=[[NSMutableArray alloc]init];
//    }
//    return _newsArray;
//}
+(NSMutableArray *)newsJson:(NSDictionary *)dic
{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSArray *news_list=[dic objectForKey:@"news_list"];
    
//    NSLog(@"%@",news_list);
    for (NSDictionary *dic in news_list) {
        NSString *auther=[dic objectForKey:@"auther"];
        NSString *channel=[dic objectForKey:@"channel"];
        NSMutableArray *images=[dic objectForKey:@"images"];
        NSString *intro=[dic objectForKey:@"intro"];
        NSString *news_title=[dic objectForKey:@"news_title"];
        NSString *readtimes=[dic objectForKey:@"readtimes"];
        NSString *Id=[dic objectForKey:@"id"];
        NSString *source=[dic objectForKey:@"source"];
        NSString *source_url=[dic objectForKey:@"source_url"];
        NSString *time=[dic objectForKey:@"time"];
        NSString *type=[dic objectForKey:@"type"];
        
        NewsModel *news=[NewsModel createNewwithId:[Id intValue] type:[type intValue] channel:channel images:images news_title:news_title intro:intro source_url:source_url time:time source:source readTimes:readtimes auther:auther];
    
        [arr addObject:news];
    }
    return arr;
    
}

+(NewsModel *)newsJson:(NSDictionary *)dic news:(NewsModel *)news
{
    


    NSArray *comments=[dic objectForKey:@"comments"];//帖子的信息
    NSArray *data=[dic objectForKey:@"data"];
    NSLog(@"%@",data);
    
    
    NSDictionary *commentDic=[[NSDictionary alloc]init];//帖子字典
    for (NSDictionary *dict in comments) {
        NSString *info=[dict objectForKey:@"info"];//帖子内容
        NSString *name=[dict objectForKey:@"name"];//帖子作者
        [commentDic setValue:info forKey:name];
    }
  
    NSMutableArray *contentArray=[[NSMutableArray alloc]init];//新闻正文数组
    for (NSDictionary *dict in data) {
        NSString *con=[dict objectForKey:@"content"];//新闻正文
        if (con!=nil) {
            [contentArray addObject:[dict objectForKey:@"content"]];
        }
    }
    
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];//新闻图片数组
    for (NSDictionary *dict in data) {
        NSDictionary *imageDic=[dict objectForKey:@"image"];//新闻图片
        if (imageDic!=nil) {
            [imageArray addObject:imageDic];
        }
    }

NewsModel *newnew=[NewsModel createNewsContent:news.news_title source:news.source auther:news.auther time:news.time intro:news.intro picArray:imageArray contentArray:contentArray commentDic:commentDic];
    
    
    return newnew;
}
+(NSMutableArray *)getNewsContentJson:(NSDictionary *)dic
{
    NSMutableArray *newContent=[[NSMutableArray alloc]init];
    
    NSArray *comments=[dic objectForKey:@"comments"];//帖子的信息
    NSArray *data=[dic objectForKey:@"data"];

    [newContent addObject:comments];
    [newContent addObject:data];
    return newContent;
}
+(PersonModel *)getPerson:(NSDictionary *)dic
{
    NSDictionary *data=[dic objectForKey:@"data"];
    PersonModel *per=[PersonModel createPersonWithName:[data objectForKey:@"name"] nickName:[data objectForKey:@"nickname"] email:[data objectForKey:@"email"] headerUrl:[data objectForKey:@"headerurl"]];
    
    NSLog(@"%@,%@,%@,%@",[data objectForKey:@"nickname"],[data objectForKey:@"email"],[data objectForKey:@"name"],[data objectForKey:@"headerurl"]);
    
    
    return per;
}
+(NSMutableArray *)getPersonArray:(NSDictionary *)dic
{
    NSMutableArray *perArray=[[NSMutableArray alloc]init];
    NSArray *data=[dic objectForKey:@"data"];


    for (NSDictionary *dict in data) {
        
        NSString *email=[dict objectForKey:@"email"];
        NSString *headerurl=[dict objectForKey:@"headerurl"];
        NSString *name=[dict objectForKey:@"name"];
        NSString *nickname=[dict objectForKey:@"nickname"];
//         NSLog(@"%@",nickname);
        PersonModel *per=[PersonModel createPersonWithName:name nickName:nickname email:email headerUrl:headerurl];
        
        [perArray addObject:per];
    }
    
    
    for (PersonModel *reee in perArray) {
        NSLog(@"email====!!!====%@",reee.headerUrl);
    }
    
    return perArray;
}
+(BOOL)uploadHeaderImage:(NSDictionary *)dic
{
   
    NSString *info=[dic objectForKey:@"info"];
     NSLog(@"%@",info);
    if ([info isEqualToString:@"上传头像成功"]) {
        return YES;
    }else{
        return NO;
    }
}
+(BOOL)tuiChuJson:(NSDictionary *)dic
{
    
    NSString *info=[dic objectForKey:@"info"];
    NSLog(@"%@",info);
    if ([info isEqualToString:@"注销登录成功"]) {
        return YES;
    }else{
        return NO;
    }
    
}
+(BOOL)changeMessage:(NSDictionary *)dic
{
    NSString *info=[dic objectForKey:@"info"];
    NSLog(@"info=======%@",info);
    if ([info isEqualToString:@"修改成功"]) {
        return YES;
    }else{
        return NO;
    }
}
+(void)getChatMessage:(NSDictionary *)dic
{
    NSArray *data=[dic objectForKey:@"data"];
    NSLog(@"%@",dic);
}
+(BOOL)sentChatMessage:(NSDictionary *)dic
{
    NSString *result=[dic objectForKey:@"result"];
    NSLog(@"result=======%@",result);
    if ([result isEqualToString:@"1"]) {
        return YES;
    }else{
        return NO;
    }
}
+(NSMutableArray *)getPublicFileMessage:(NSDictionary *)dic{
    NSMutableArray *fileArray=[[NSMutableArray alloc]init];
    NSDictionary *filelist=[dic objectForKey:@"filelist"];
    NSArray *pub_file=[filelist objectForKey:@"pub_file"];
//    NSLog(@"%@",pub_file);
    for (NSDictionary *dict in pub_file) {
        NSString *author=[dict objectForKey:@"author"];
        NSString *fileDescription=[dict objectForKey:@"description"];
        NSString *dtimes=[dict objectForKey:@"dtimes"];
        NSString *Id=[dict objectForKey:@"id"];
        NSString *image_url=[dict objectForKey:@"image_url"];
        NSString *length=[dict objectForKey:@"length"];
        
        NSString *mimetype=[dict objectForKey:@"mimetype"];
        NSString *name=[dict objectForKey:@"name"];
        NSString *time=[dict objectForKey:@"time"];
        NSString *tname=[dict objectForKey:@"tname"];
        NSString *type=[dict objectForKey:@"type"];
        NSString *url=[dict objectForKey:@"url"];
        
        FileModel *file=[FileModel createFileWithName:name isPerson:NO Id:Id type:[type intValue] mimetype:mimetype image_url:image_url url:url fileDescription:fileDescription author:author tname:tname time:time dtimes:[dtimes intValue] length:[length longLongValue]];
        [fileArray addObject:file];
    }

    return fileArray;
}
+(NSMutableArray *)getPersonFileMessage:(NSDictionary *)dic
{
    NSMutableArray *fileArray=[[NSMutableArray alloc]init];
    NSDictionary *filelist=[dic objectForKey:@"filelist"];
    NSArray *per_file=[filelist objectForKey:@"per_file"];
    
//    NSLog(@"%@",per_file);
    for (NSDictionary *dict in per_file) {
        NSString *author=[dict objectForKey:@"author"];
        NSString *fileDescription=[dict objectForKey:@"description"];
        NSString *dtimes=[dict objectForKey:@"dtimes"];
        NSString *Id=[dict objectForKey:@"id"];
        NSString *image_url=[dict objectForKey:@"image_url"];
        NSString *length=[dict objectForKey:@"length"];
        
        NSString *mimetype=[dict objectForKey:@"mimetype"];
        NSString *name=[dict objectForKey:@"name"];
        NSString *time=[dict objectForKey:@"time"];
        NSString *tname=[dict objectForKey:@"tname"];
        NSString *type=[dict objectForKey:@"type"];
        NSString *url=[dict objectForKey:@"url"];
        
        FileModel *file=[FileModel createFileWithName:name isPerson:YES Id:Id type:[type intValue] mimetype:mimetype image_url:image_url url:url fileDescription:fileDescription author:author tname:tname time:time dtimes:[dtimes intValue] length:[length longLongValue]];
        [fileArray addObject:file];
    }
    
    
    return fileArray;
}

@end
