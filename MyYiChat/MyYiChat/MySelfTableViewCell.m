//
//  MySelfTableViewCell.m
//  MyYiChat
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MySelfTableViewCell.h"

@implementation MySelfTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.headerImage.layer.cornerRadius=30;
    self.headerImage.layer.masksToBounds=YES;
    UIImage *ima= [UIImage imageNamed:@"bubbleSelf.png"];
    [ima resizableImageWithCapInsets:UIEdgeInsetsMake(4, 8, 4, 8) resizingMode:UIImageResizingModeTile];
    self.headerImage.image=ima;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
