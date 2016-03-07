//
//  LoginViewController.h
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostRequestToServer.h"
#import "MyJson.h"
#import "MainViewController.h"
@interface LoginViewController : UIViewController<PostRequestToServerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *regist;
@property (weak, nonatomic) IBOutlet UILabel *alter;

@end
