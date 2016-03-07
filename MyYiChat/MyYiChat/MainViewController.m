//
//  MainViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
-(void)initUI
{
    ChatViewController *chat=[[ChatViewController alloc]init];
    UINavigationController *chatNa=[self createNavigationControllerWithViewController:chat title:@"聊天中心" imageName:@"main.png"];
    NewViewController *new=[[NewViewController alloc]init];
    UINavigationController *newNa=[self createNavigationControllerWithViewController:new title:@"新闻中心" imageName:@"news.png"];
    FilesViewController *files=[[FilesViewController alloc]init];
    UINavigationController *filesNa=[self createNavigationControllerWithViewController:files title:@"文件" imageName:@"file.png"];
    PersonViewController *person=[[PersonViewController alloc]init];
    UINavigationController *personNa=[self createNavigationControllerWithViewController:person title:@"个人中心" imageName:@"person.png"];
    UITabBarController *tabBarControll=[[UITabBarController alloc]init];
    tabBarControll.viewControllers=@[chatNa,newNa,filesNa,personNa];
    tabBarControll.tabBar.hidden=NO;
   UIWindow *mainWin = [[UIApplication sharedApplication].delegate window];
    mainWin.rootViewController=tabBarControll;
}
-(UINavigationController *)createNavigationControllerWithViewController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName
{
    viewController.tabBarItem.title=title;
    viewController.tabBarItem.image=[UIImage imageNamed:imageName];
//    viewController.tabBarItem.selectedImage=[UIImage imageNamed:selectedImageName];
    UINavigationController *na=[[UINavigationController alloc]initWithRootViewController:viewController];
    return na;
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
