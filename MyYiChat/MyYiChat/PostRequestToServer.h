//
//  PostRequestToServer.h
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
@protocol PostRequestToServerDelegate;
@interface PostRequestToServer : NSObject<ASIHTTPRequestDelegate,ASIProgressDelegate>

@property(nonatomic,assign)id<ASIProgressDelegate>progressDelegate;
@property(nonatomic,assign)id<PostRequestToServerDelegate>delegate;
-(void)downLoadFileWitnUrl:(NSString *)url name:(NSString *)name;
-(void)stopDownload;

-(void)sentChatWithName:(NSString *)name chat:(NSString *)chat;
-(void)getFriends;
-(void)changePersonMessageLikeNickName:(NSString *)nickName email:(NSString *)email;
-(void)tuiChu;
-(void)uploadHeaderImage:(UIImage *)image;
-(void)getPersonInfo;
-(void)getNewsContent:(NSString *)urlString;
-(void)getNews;
-(void)getChatMessage;
-(void)registIdWithUrl:(NSString *)urlString userName:(NSString *)userName psw:(NSString *)psw nickName:(NSString *)nickName email:(NSString *)email;
-(void)loginWithUrl:(NSString *)urlString userName:(NSString *)userName psw:(NSString *)psw;
-(void)getFileMessge;
@end
@protocol PostRequestToServerDelegate <NSObject>

-(void)downLoadFileWitnUrlProgress:(float)newProgress;

-(void)getFileMessgeSucceed:(ASIHTTPRequest *)request;
-(void)getFileMessgeFailed:(ASIHTTPRequest *)request;
-(void)sentChatWithNameSucceed:(ASIHTTPRequest *)request;

-(void)sentChatWithNameFailed:(ASIHTTPRequest *)request;
-(void)getChatMessageSucceed:(ASIHTTPRequest *)request;

-(void)getChatMessageFailed:(ASIHTTPRequest *)request;
-(void)changePersonMessageSucceed:(ASIHTTPRequest *)request;
-(void)changePersonMessageFailed:(ASIHTTPRequest *)request;
-(void)getFriendsSucceed:(ASIHTTPRequest *)request;
-(void)getFriendsFailed:(ASIHTTPRequest *)request;
-(void)tuiChuSucceed:(ASIHTTPRequest *)request;
-(void)tuiChuFailed:(ASIHTTPRequest *)request;
-(void)getPersonInfoSucceed:(ASIHTTPRequest *)request;
-(void)getPersonInfoFailed:(ASIHTTPRequest *)request;
-(void)getNewsContentSucceed:(ASIHTTPRequest *)request;
-(void)getNewsContentFailed:(ASIHTTPRequest *)request;
-(void)getNewsSucceed:(ASIHTTPRequest *)request;
-(void)getNewsFailed:(ASIHTTPRequest *)request;
-(void)loginSucceed:(ASIHTTPRequest *)request;
-(void)loginFailed:(ASIHTTPRequest *)request;
-(void)registSucceed:(ASIHTTPRequest *)request;
-(void)registFailed:(ASIHTTPRequest *)request;
-(void)uploadHeaderImageSucceed:(ASIHTTPRequest *)request;
-(void)uploadHeaderImageFailed:(ASIHTTPRequest *)request;
@end