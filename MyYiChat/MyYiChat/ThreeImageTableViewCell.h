//
//  ThreeImageTableViewCell.h
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleNew;
@property (weak, nonatomic) IBOutlet UILabel *sourceNew;
@property (weak, nonatomic) IBOutlet UIImageView *imageNew1;
@property (weak, nonatomic) IBOutlet UIImageView *imageNew2;
@property (weak, nonatomic) IBOutlet UIImageView *imageNew3;
@property(nonatomic,strong)NSArray *imageArray;
@end
