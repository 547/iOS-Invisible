//
//  UsefulHeader.h=========常用头文件和宏定义
//  MyYiChat
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Seven. All rights reserved.
//

#ifndef UsefulHeader_h
#define UsefulHeader_h


#import "PostRequestToServer.h"
#import "MyJson.h"
#import "NSString+More.h"
#import "UIImageView+WebCache.h"


#define IMAGEURLHEAD @"http://localhost:8080/st"//image的url的头部
#define URLHEAD @"http://localhost:8080/st/s"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width//屏幕宽
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height//屏幕高
#define ONECHOOSEALTER(title) UIAlertController *alter=[UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
}];\
[alter addAction:action1];\
[self presentViewController:alter animated:YES completion:nil];
#define TWOCHOOSEALTER(title,buttonTitle,action)UIAlertController *alter=[UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *action1=[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {action;\
}];\
UIAlertAction *action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];\
[alter addAction:action1];\
[alter addAction:action2]\
[self presentViewController:alter animated:YES completion:nil];




#endif /* UsefulHeader_h */
