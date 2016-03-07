//
//  LoginViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "NSString+More.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
{
    PostRequestToServer *loginQuest;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
-(void)initUI
{
    self.title=@"登录";
    self.login.layer.cornerRadius=6;
    self.regist.layer.cornerRadius=6;
    [self.regist addTarget:self action:@selector(registId) forControlEvents:UIControlEventTouchUpInside];
    [self.login addTarget:self action:@selector(loginId) forControlEvents:UIControlEventTouchUpInside];
}
//点击登录
-(void)loginId
{
    if ([NSString trim:self.userName.text].length==0||[NSString trim:self.passWord.text].length==0) {
        self.alter.text=@"用户名或密码不能为空";
        return;
    }
    //登录请求
   loginQuest=[[PostRequestToServer alloc]init];
    [loginQuest loginWithUrl:@"http://localhost:8080/st/s" userName:[NSString trim:self.userName.text] psw:[NSString trim:self.passWord.text]];
    loginQuest.delegate=self;


}
//点击注册按钮，前往注册页面
-(void)registId
{
    RegistViewController *registView=[[RegistViewController alloc]init];
    [self.navigationController pushViewController:registView animated:YES];
}
-(void)loginSucceed:(ASIHTTPRequest *)request
{
 NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
    
    if ([MyJson loginJson:dic]) {//登录成功
        //
        MainViewController *mainView=[[MainViewController alloc]init];//tabbar页面
        [self presentViewController:mainView animated:YES completion:nil];
    }else {
        self.alter.text=@"用户名或密码错误";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
