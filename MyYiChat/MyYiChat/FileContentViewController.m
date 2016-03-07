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
#define RECT CGRectMake(0, 64, SCREENWIDTH, 260)
@interface FileContentViewController ()

@end

@implementation FileContentViewController
{
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
    self.navigationController.navigationBar.hidden=NO;
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
                [self createImageView];
            }else {
                //展示pdf文档
            }
        }
            break;
        case 1:
            //MP3
            [self createMusicPlayer];
            break;
        case 2:
            //MP4
            [self createMoiveViewController];
            break;
        case 3:
            //doc
            break;
        case 4:
            //jpg
            [self createImageView];
            break;
            
        default:
            break;
    }



}
-(void)showPDF
{

}
-(void)createImageView
{
    UIImageView *imagaV=[[UIImageView alloc]initWithFrame:RECT];
    imagaV.image=[UIImage imageWithContentsOfFile:[NSString getPathOfDoucoment:_file.tname]];
    [self.view addSubview:imagaV];
}
-(void)createMusicPlayer
{
//    NSString *path=[NSString getPathOfDoucoment:_file.tname];
    NSString *path=[[NSBundle mainBundle]pathForResource:@"beijingdejinshanshang" ofType:@"mp3"];
    player=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    [player play];

}
-(void)createMoiveViewController
{
    NSString *path=[NSString getPathOfDoucoment:_file.tname];
   moviePlayer= [[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:path]];
    moviePlayer.view.frame=RECT;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer play];
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
