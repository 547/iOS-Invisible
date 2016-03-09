//
//  MyButton.h
//  MyYiChat
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsefulHeader.h"

@interface MyButton : UIButton
typedef NS_ENUM(NSInteger,MyButtonStatus){//定义枚举
    MyButtonDefaultStatus=0,
    MyButtonDownloadingStatus,
    MyButtonPauseStatus,
    MyButtonDownloadSuccess
};
@property(nonatomic,readwrite)MyButtonStatus buttonStatus;//描述枚举
@property(nonatomic,strong)FileModel *file;
@property(nonatomic,strong)UIView *buttonView;
@property(nonatomic,assign)float progress;
@end
