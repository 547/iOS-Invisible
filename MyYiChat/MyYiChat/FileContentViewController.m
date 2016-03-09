//
//  FileContentViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "FileContentViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UsefulHeader.h"
#define RECT CGRectMake(0, 0, SCREENWIDTH, 260)
@interface FileContentViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FileContentViewController
{
    UITableView *table;
    AVAudioPlayer *player;
    MPMoviePlayerController *moviePlayer;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
-(void)initUI
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden=NO;
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64-49) style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    table.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    

    self.title=_file.name;
    NSLog(@"====++++====%@",_file.name);
    /*
     type:
     0-png\pdf
     1-mp3
     2-mp4
     3-doc
     4-jpg
     
     */
    switch (_file.type) {
        case 0:{
            if ([_file.url rangeOfString:@"png"].length>0) {
                //展示图片
               table.tableHeaderView = [self createImageView];
            }else {
                //展示pdf文档
                table.tableHeaderView =[self createWeb];

            }
        }
            break;
        case 1:
        case 2:
            //MP4
          table.tableHeaderView =  [self createMoiveViewController];
            break;
        case 3:
            //doc
            table.tableHeaderView =[self createWeb];
            break;
        case 4:
            //jpg
           table.tableHeaderView = [self createImageView];
            break;
            
        default:
            break;
    }
    
    



}
-(UIWebView *)createWeb
{
    UIWebView *web=[[UIWebView alloc]initWithFrame:RECT];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[NSString getPathOfDoucoment:[NSString stringWithFormat:@"file%@",_file.tname]]]]];
    return web;
}
-(void)showPDF//展示PDF文件
{
//    CGPDFDocumentRef 
//    CGContextRef  path;
//    path=CFStringCreateWithCString(NULL, <#const char *cStr#>, <#CFStringEncoding encoding#>)
//CGContextDrawPDFPage(CGContextRef  _Nullable c, <#CGPDFPageRef  _Nullable page#>)
}
-(UIImageView *)createImageView
{
    UIImageView *imagaV=[[UIImageView alloc]initWithFrame:RECT];
    imagaV.image=[UIImage imageWithContentsOfFile:[NSString getPathOfDoucoment:[NSString stringWithFormat:@"file%@",_file.tname]]];
    return imagaV;
    
}
-(void)createMusicPlayer//播放音乐
{
//    NSString *path=[NSString getPathOfDoucoment:_file.tname];
    NSString *path=[[NSBundle mainBundle]pathForResource:@"beijingdejinshanshang" ofType:@"mp3"];
    player=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    [player play];

}
-(UIView *)createMoiveViewController//播放视频
{
    NSString *path=[NSString getPathOfDoucoment:[NSString stringWithFormat:@"file%@",_file.tname]];
   moviePlayer= [[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:path]];
    moviePlayer.view.frame=RECT;
    [moviePlayer play];
    return moviePlayer.view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 40;

    }else if (indexPath.row==1||indexPath.row==5){
    return 80;
    }else if (indexPath.row==6){
    
        return 260;
    }else{
        return 30;
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 7;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.font=SYSTEMFONT;
    cell.textLabel.text=nil;
    cell.textLabel.textColor=[UIColor blackColor];
    
    switch (indexPath.row) {
        case 0:
            //
            cell.backgroundColor=[UIColor lightGrayColor];
            cell.textLabel.font=TITLEFONT;
            cell.textLabel.text=_file.name;
            cell.textLabel.textColor=[UIColor blueColor];
            break;
        case 1:
            //
            cell.textLabel.font=TITLEFONT;
            cell.textLabel.text=@"资源介绍：";
            cell.textLabel.textColor=[UIColor blueColor];
            break;
        case 2:
            //
            cell.textLabel.font=CONTENTFONT;
            cell.textLabel.text=[NSString stringWithFormat:@"上传者：%@",_file.author];
            break;
        case 3:
            //
            cell.textLabel.font=CONTENTFONT;
            cell.textLabel.text=[NSString stringWithFormat:@"上传时间：%@",_file.time];
            break;
        case 4:
            //
            cell.textLabel.font=CONTENTFONT;
            cell.textLabel.text=[NSString stringWithFormat:@"下载次数：%d",_file.dtimes];
            break;
        case 5:
            //
            cell.textLabel.font=TITLEFONT;
            cell.textLabel.text=@"内容介绍：";
            cell.textLabel.textColor=[UIColor blueColor];
            break;
        case 6:
            //
            cell.textLabel.numberOfLines=0;
            cell.textLabel.font=CONTENTFONT;
            cell.textLabel.text=_file.fileDescription;
            
            break;
        default:
            break;
    }
    return cell;
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
