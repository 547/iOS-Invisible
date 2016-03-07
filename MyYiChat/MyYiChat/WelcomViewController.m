//
//  WelcomViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "WelcomViewController.h"
#import "MainViewController.h"
@interface WelcomViewController ()

@end

@implementation WelcomViewController
{
    UIImageView *welcomImage;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
-(void)initUI
{
    welcomImage=[[UIImageView alloc]initWithFrame:self.view.frame];
    welcomImage.image=[UIImage imageNamed:@"1-568h@2x.png"];
    [self.view addSubview:welcomImage];
//    [UIView animateWithDuration:3 animations:^{
//        welcomImage.alpha=0.3;
//    } completion:^(BOOL finished) {
//        //
//    }];
}
-(void)viewWillAppear:(BOOL)animated
{

    //判断是否已经登录
    if ([TestLogin isLogined]) {//已经登录
        NSLog(@"已经登录");
        MainViewController *mainView=[[MainViewController alloc]init];
        [self goToNextViewControll:mainView];
        
    } else {
        NSLog(@"未登录");
            
            LoginViewController *loginView=[[LoginViewController alloc]init];
            [self goToNextViewControll:loginView];

    }

}
-(void)goToNextViewControll:(UIViewController *)viewController
{
    [UIView animateWithDuration:2 animations:^{
        welcomImage.alpha=0.3;
    } completion:^(BOOL finished) {
        
    UIWindow *mainWin= [[UIApplication sharedApplication].delegate window];
    UINavigationController *na=[[UINavigationController alloc]initWithRootViewController:viewController];
    mainWin.rootViewController=na;
    
    [UIView animateWithDuration:1 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:mainWin cache:YES];//设置翻页动画
    }];
    }];
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
