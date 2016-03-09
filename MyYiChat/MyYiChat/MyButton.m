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
    _buttonView=[[UIView alloc]initWithFrame:self.frame];
    _buttonView.backgroundColor=[UIColor redColor];
    _buttonView.alpha=0.4;
    [self setTitle:@"下载" forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
