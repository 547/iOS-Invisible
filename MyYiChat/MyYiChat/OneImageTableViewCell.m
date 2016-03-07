//
//  OneImageTableViewCell.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "OneImageTableViewCell.h"

@implementation OneImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.imageNew.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
