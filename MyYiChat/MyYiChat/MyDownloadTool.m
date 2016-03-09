//
//  MyDownloadTool.m
//  MyYiChat
//
//  Created by mac on 16/3/9.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MyDownloadTool.h"

@implementation MyDownloadTool
{
    ASIFormDataRequest *request;
}
-(void)starDownloadWithFile:(FileModel *)file
{
    _file=file;
    request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:_file.url]];
    request.downloadProgressDelegate=self;
    request.allowResumeForFileDownloads=YES;
    [request setTemporaryFileDownloadPath:[NSString getPathOfDoucoment:[NSString stringWithFormat:@"temp%@",_file.tname]]];
    [request setDownloadDestinationPath:[NSString getPathOfDoucoment:[NSString stringWithFormat:@"file%@",_file.tname]]];
    [request startAsynchronous];
}
-(void)stopDownload
{
    [request cancel];
    request=nil;
}
-(BOOL)isDownloading
{
    if (request==nil) {//暂停
        return NO;
    }else{
        return YES;
    }
}
-(void)setProgress:(float)newProgress
{
    [self.delegate getProgress:newProgress];//这个是让使用者类
    
    _progress=newProgress;
    NSNotificationCenter *cente=  [NSNotificationCenter defaultCenter];
    [cente postNotificationName:@"newProgress" object:self userInfo:nil];
    
}
@end
