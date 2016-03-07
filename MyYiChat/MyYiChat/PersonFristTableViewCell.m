//
//  PersonFristTableViewCell.m
//  MyYiChat
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "PersonFristTableViewCell.h"

@implementation PersonFristTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.image.layer.cornerRadius=45;
    self.image.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
