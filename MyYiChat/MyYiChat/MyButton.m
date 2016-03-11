//
//  MyButton.m
//  MyYiChat
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton
-(void)awakeFromNib//从xib那初始化
{
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(getInfo:) name:@"newProgress" object:nil];
    _buttonView=[[UIView alloc]initWithFrame:self.bounds];
    _buttonView.backgroundColor=[UIColor redColor];
    _buttonView.alpha=0.3;
    [self addSubview:_buttonView];
    _buttonView.userInteractionEnabled=NO;
    self.buttonStatus=MyButtonDefaultStatus;
    
}
-(void)getInfo:(NSNotification *)info
{
    MyDownloadTool *down=(MyDownloadTool *)info.object;
    if ([_file.tname isEqualToString:down.file.tname])
    {
        self.progress=down.progress;
        
    }
}
-(void)setProgress:(float)progress//重写Set方法
{
    _progress=progress;
    

    CGFloat height=self.frame.size.height*(1-_progress);
    CGFloat y=self.frame.size.height*_progress;
    _buttonView.frame=CGRectMake(0, y, self.frame.size.width, height);
    
    if (_progress==1.0) {
    self.buttonStatus=MyButtonDownloadSuccess;
        
    }else
    {
    self.buttonStatus=MyButtonDownloadingStatus;
    }

}
//重写set方法
-(void)setButtonStatus:(MyButtonStatus)buttonStatus
{
    _buttonStatus=buttonStatus;
    switch (_buttonStatus) {
        case MyButtonDefaultStatus:
            //默认状态
        
            [self setTitle:@"下载" forState:UIControlStateNormal];
            break;
        case MyButtonDownloadingStatus:
            //正在下载
            [self setTitle:[NSString stringWithFormat:@"%0.2f%%",_progress*100] forState:UIControlStateNormal];
            break;
        case MyButtonPauseStatus:
            //暂停下载

            [self setTitle:@"继续下载" forState:UIControlStateNormal];
            break;
        case MyButtonDownloadSuccess:
            //下载完成
            [self setTitle:@"查看" forState:UIControlStateNormal];
            _buttonView.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, 0);
            break;
        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
