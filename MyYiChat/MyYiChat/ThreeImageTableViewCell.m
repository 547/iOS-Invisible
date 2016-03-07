//
//  ThreeImageTableViewCell.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ThreeImageTableViewCell.h"

@implementation ThreeImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _imageArray=@[self.imageNew1,self.imageNew2,self.imageNew3];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
