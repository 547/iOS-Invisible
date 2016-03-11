//
//  MySelfTableViewCell.m
//  MyYiChat
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MySelfTableViewCell.h"
#import "UIImageView+WebCache.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
@implementation MySelfTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.headerImage.layer.cornerRadius=30;
    self.headerImage.layer.masksToBounds=YES;
    self.chatLabel.numberOfLines=0;
    
}
-(void)setChat:(ChatModel *)chat
{
    _chat=chat;
    [self getcellFrameWithModel:_chat];
    [self showCellWithModel:_chat];
}
//根据传进来的对象计算cell的各个控件的Frame
-(CGRect)getcellFrameWithModel:(ChatModel *)cha
{
    CGSize headerSize=self.headerImage.frame.size;
    CGFloat headerX=SCREENWIDTH-5-headerSize.width;
    CGFloat headerY=5;
    CGRect headerRect={{headerX,headerY},headerSize};
    self.headerImage.frame=headerRect;
    self.headerButton.frame=headerRect;
    
    NSString *time=[cha.chatContent componentsSeparatedByString:@"|"][0];
    NSString *content=[cha.chatContent componentsSeparatedByString:@"|"][1];
    
    CGRect chatRect = [content boundingRectWithSize:CGSizeMake(headerX-5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];//计算出聊天内容的rect
    self.chatImage.frame=CGRectMake(headerX-5-chatRect.size.width, headerY, chatRect.size.width+20, chatRect.size.height+20);
   UIImage *image= [UIImage imageNamed:@"bubbleSelf.png"];
   image = [image stretchableImageWithLeftCapWidth:25 topCapHeight:20];
    self.chatImage.image=image;
    
    self.chatLabel.center=self.chatImage.center;
    self.chatLabel.bounds=CGRectMake(0, 0, chatRect.size.width, chatRect.size.height);
    CGRect timeRect=[time boundingRectWithSize:CGSizeMake(MAXFLOAT, 10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
    self.timeLabel.center=self.chatImage.center;
    self.timeLabel.bounds=CGRectMake(0, 0, timeRect.size.width, timeRect.size.height);
    CGFloat he= self.headerButton.frame.size.height>self.chatImage.frame.size.height?self.headerButton.frame.size.height:self.chatImage.frame.size.height;
    NSLog(@"he=====%f",he);
    self.bounds=CGRectMake(0, 0, self.headerButton.frame.size.width+self.chatImage.frame.size.width+5, he);
    return self.bounds;
}
-(void)showCellWithModel:(ChatModel *)cha
{
    [self.headerImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/st%@",_head_url]] placeholderImage:[UIImage imageNamed:@"head.png"]];
    NSString *time=[cha.chatContent componentsSeparatedByString:@"|"][0];
    NSString *content=[cha.chatContent componentsSeparatedByString:@"|"][1];
    self.chatLabel.numberOfLines=0;
    self.chatLabel.font=[UIFont systemFontOfSize:17];
    self.chatLabel.text=content;
    self.timeLabel.text=time;
    
}
+(CGFloat)getCellHeightWithModel:(ChatModel *)cha
{
    MySelfTableViewCell *cell=[[MySelfTableViewCell alloc]init];
    CGRect rect = [cell getcellFrameWithModel:cha];
    NSLog(@"%@",NSStringFromCGRect(rect));
    return rect.size.height;
}











- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
