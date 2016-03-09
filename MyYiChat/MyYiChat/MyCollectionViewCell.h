//
//  MyCollectionViewCell.h
//  MyYiChat
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@protocol MyCollectionViewCellDelegate;
@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet MyButton *contentButton;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewLabel;
@property(nonatomic,assign)id<MyCollectionViewCellDelegate>delegate;
@end
@protocol MyCollectionViewCellDelegate <NSObject>

-(void)dainiji;

@end