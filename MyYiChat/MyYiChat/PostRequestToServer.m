//
//  PostRequestToServer.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "PostRequestToServer.h"
#import "NSString+More.h"
#import "Base64.h"
@implementation PostRequestToServer

//注册
-(void)registIdWithUrl:(NSString *)urlString userName:(NSString *)userName psw:(NSString *)psw nickName:(NSString *)nickName email:(NSString *)email
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.tag=100;
    [request setPostValue:@"ST_R" forKey:@"command"];
    [request setPostValue:userName forKey:@"name"];
    [request setPostValue:psw forKey:@"psw"];
    [request setPostValue:nickName forKey:@"nickname"];
    [request setPostValue:email forKey:@"email"];
    request.delegate=self;
    [request startAsynchronous];
   
}
//登录
-(void)loginWithUrl:(NSString *)urlString userName:(NSString *)userName psw:(NSString *)psw
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.tag=101;
    [request setPostValue:@"ST_L" forKey:@"command"];
    [request setPostValue:userName forKey:@"name"];
    [request setPostValue:psw forKey:@"psw"];

    request.delegate=self;
    [request startAsynchronous];
    
}
-(void)getNews
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/st/news/news_list.json"]];
    request.tag=102;
    request.delegate=self;
    [request startAsynchronous];
}
-(void)getNewsContent:(NSString *)urlString
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",urlString]]];
    request.tag=103;
    request.delegate=self;
    [request startAsynchronous];
}
-(void)getPersonInfo
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/st/s"]];
    request.tag=104;
   NSString *access_token= [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    [request setPostValue:@"ST_GPI" forKey:@"command"];
    [request setPostValue:access_token forKey:@"access_token"];
    request.delegate=self;
    [request startAsynchronous];


}
-(void)uploadHeaderImage:(UIImage *)image
{
     NSString *access_token= [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/st/s?command=ST_H&access_token=%@",access_token]]];
    request.tag=105;
    NSData *data=UIImageJPEGRepresentation(image, 1);

    [request setPostBody:(NSMutableData *)data];
    request.delegate=self;
    [request startAsynchronous];
}
-(void)tuiChu
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/st/s"]];
    request.tag=106;
    NSString *access_token= [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    [request setPostValue:@"ST_LO" forKey:@"command"];
    [request setPostValue:access_token forKey:@"access_token"];
    request.delegate=self;
    [request startAsynchronous];
}
-(void)changePersonMessageLikeNickName:(NSString *)nickName email:(NSString *)email
{
    if ([NSString trim:nickName]!=nil&&[NSString trim:email]!=nil) {
        
        NSLog(@"nick=22===%@,emial=22==%@",[NSString trim:nickName],[NSString trim:email]);
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/st/s"]];
        request.tag=107;
        NSString *access_token= [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
        [request setPostValue:@"ST_SPI" forKey:@"command"];
        [request setPostValue:access_token forKey:@"access_token"];
        request.delegate=self;
        [request startAsynchronous];
    }
}
-(void)getFriends
{
     NSString *access_token= [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/st/s?command=%@&access_token=%@",@"ST_FL",access_token]]];
    request.delegate=self;
    request.tag=108;
    [request startAsynchronous];
    
}
-(void)getChatMessage
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/st/s"]];
    request.tag=109;
    NSString *access_token= [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    [request setPostValue:@"ST_CG" forKey:@"command"];
    [request setPostValue:access_token forKey:@"access_token"];
    request.delegate=self;
    [request startAsynchronous];


}
-(void)sentChatWithName:(NSString *)name chat:(NSString *)chat
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/st/s"]];
    request.tag=110;
    NSString *access_token= [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    [request setPostValue:@"ST_CS" forKey:@"command"];
    [request setPostValue:access_token forKey:@"access_token"];
    [request setPostValue:name forKey:@"friendname"];
    [request setPostValue:[chat base64EncodedString] forKey:@"chatinfo"];
    request.delegate=self;
    [request startAsynchronous];
}
-(void)getFileMessge
{
    NSString *access_token= [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/st/s?command=%@&access_token=%@",@"ST_F_FL",access_token]]];
    request.delegate=self;
    request.tag=111;
    [request startAsynchronous];
}
-(void)downLoadFileWitnUrl:(NSString *)url
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    request.tag=112;
    NSString *finalPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:@"download"];
    NSString *tempPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:@"tempDownload"];
    request.downloadDestinationPath=finalPath;
    request.temporaryFileDownloadPath=tempPath;
    request.allowResumeForFileDownloads=YES;
    [request startAsynchronous];
}
#pragma mask==ASIHTTPRequestDelegate
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==100) {
        [self.delegate registSucceed:request];
    }
    if (request.tag==101) {
        [self.delegate loginSucceed:request];
    }
    if (request.tag==102) {
        [self.delegate getNewsSucceed:request];
    }
    if (request.tag==103) {
        [self.delegate getNewsContentSucceed:request];
    }
    if (request.tag==104) {
        [self.delegate getPersonInfoSucceed:request];
    }
    if (request.tag==105) {
        [self.delegate uploadHeaderImageSucceed:request];
    }
    if (request.tag==106) {
        [self.delegate tuiChuSucceed:request];
    }
    if (request.tag==107) {
        [self.delegate changePersonMessageSucceed:request];
    }
    if (request.tag==108) {
        [self.delegate getFriendsSucceed:request];
    }
    if (request.tag==109) {
        [self.delegate getChatMessageSucceed:request];
    }
    if (request.tag==110) {
        [self.delegate sentChatWithNameSucceed:request];
    }
    if (request.tag==111) {
        [self.delegate getFileMessgeSucceed:request];
    }
    if (request.tag==112) {
        [self.delegate downLoadFileWitnUrlSucceed:request];
    }

}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    if (request.tag==100) {
        [self.delegate registFailed:request];
    }
    if (request.tag==101) {
        [self.delegate loginFailed:request];
    }
    if (request.tag==102) {
        [self.delegate getNewsFailed:request];
    }
    if (request.tag==103) {
        [self.delegate getNewsContentFailed:request];
    }
    if (request.tag==104) {
        [self.delegate getPersonInfoFailed:request];
    }
    if (request.tag==105) {
        [self.delegate uploadHeaderImageFailed:request];
    }
    if (request.tag==106) {
        [self.delegate tuiChuFailed:request];
    }
    if (request.tag==107) {
        [self.delegate changePersonMessageFailed:request];
    }
    if (request.tag==108) {
        [self.delegate getFriendsFailed:request];
    }
    if (request.tag==109) {
        [self.delegate getChatMessageFailed:request];
    }
    if (request.tag==110) {
        [self.delegate sentChatWithNameFailed:request];
    }
    if (request.tag==111) {
        [self.delegate getFileMessgeFailed:request];
    }
    if (request.tag==112) {
        [self.delegate downLoadFileWitnUrlFailed:request];
    }
}
@end
