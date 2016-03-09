//
//  MyDownloadTool.h=====文件下载器
//  MyYiChat
//
//  Created by mac on 16/3/9.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UsefulHeader.h"
@protocol MyDownloadToolDelegate;
@interface MyDownloadTool : NSObject<ASIProgressDelegate>
@property(nonatomic,assign)id<MyDownloadToolDelegate>delegate;
@property(nonatomic,strong)FileModel *file;
@property(nonatomic,assign)float progress;
-(BOOL)isDownloading;
-(void)stopDownload;
-(void)starDownloadWithFile:(FileModel *)file;
@end
@protocol MyDownloadToolDelegate <NSObject>

-(void)getProgress:(float)newProgress;

@end