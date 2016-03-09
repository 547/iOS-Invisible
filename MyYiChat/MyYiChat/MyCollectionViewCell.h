//
//  MyCollectionViewCell.h
//  MyYiChat
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"MyButton.h"
@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet MyButton *contentButton;
//@class MyButton;//防止循环引用
@end
