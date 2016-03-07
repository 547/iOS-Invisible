//
//  ChattingRoomViewController.h
//  MyYiChat
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"
@interface ChattingRoomViewController : UIViewController
@property(nonatomic,strong)PersonModel *friends;
@property(nonatomic,strong)PersonModel *mySelf;
@end
