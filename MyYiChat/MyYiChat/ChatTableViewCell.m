//
//  ChatTableViewCell.m
//  MyYiChat
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.headerImage.layer.cornerRadius=35;
    self.headerImage.layer.masksToBounds=YES;
    self.messageLabel.layer.cornerRadius=30;
    self.messageLabel.layer.masksToBounds=YES;
    self.headerImage.image=[UIImage imageNamed:@"head.png"];
    self.nameLabel.text=nil;
    self.contentLabel.text=nil;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
