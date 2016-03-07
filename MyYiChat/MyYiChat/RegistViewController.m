//
//  RegistViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "RegistViewController.h"
#import "PostRequestToServer.h"
@interface RegistViewController ()<PostRequestToServerDelegate>

@end

@implementation RegistViewController
{
    PostRequestToServer *regist;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
-(void)initUI
{
    self.title=@"注册";
    self.regist.layer.cornerRadius=6;
    [self.regist addTarget:self action:@selector(foreJudgeOfTextFileBeforeRegist) forControlEvents:UIControlEventTouchUpInside];

}
//点击注册
-(void)foreJudgeOfTextFileBeforeRegist
{
   
    if ([NSString trim:self.userName.text].length==0||[NSString trim:self.passWord.text].length==0||[NSString trim:self.passWordAgi.text].length==0) {
        self.alter.text=@"用户名或密码不能为空";
        return;
    }
    if (![[NSString trim:self.passWordAgi.text] isEqualToString:[NSString trim:self.passWord.text]]) {
        self.alter.text=@"两次输入的密码不相同";
        return;
    }
    if ([NSString trim:self.nickName.text].length==0) {
        self.alter.text=@"昵称不能为空";
        return;
    }
    if ([NSString trim:self.email.text].length==0) {
        self.alter.text=@"邮箱不能为空";
        return;
    }
    //注册请求
    regist=[[PostRequestToServer alloc]init];
    [regist registIdWithUrl:@"http://localhost:8080/st/s" userName:[NSString trim:self.userName.text] psw:[NSString trim:self.passWord.text] nickName:[NSString trim:self.nickName.text] email:[NSString trim:self.email.text]];
    regist.delegate=self;
}
-(void)registSucceed:(ASIHTTPRequest *)request
{
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
   NSString *result = [dic objectForKey:@"result"];
    if ([result intValue]==1) {
        self.alter.text=@"注册成功，请登录";
        
        [self performSelector:@selector(goToLogin) withObject:self afterDelay:0.5];
        
        return;
    }
    if ([result intValue]==0) {
        self.alter.text=[NSString stringWithFormat:@"注册失败，%@",[dic objectForKey:@"error"]];
    }
}
-(void)goToLogin
{
[self.navigationController popViewControllerAnimated:YES];
}






-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
