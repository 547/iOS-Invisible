//
//  MyButton.h
//  MyYiChat
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileModel.h"
@interface MyButton : UIButton
@property(nonatomic,strong)FileModel *file;
@property(nonatomic,strong)UIView *buttonView;
@end
