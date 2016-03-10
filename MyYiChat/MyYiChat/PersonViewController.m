//
//  PersonViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonFristTableViewCell.h"
#import "UsefulHeader.h"
#import "PersonModel.h"
#import "WelcomViewController.h"

@interface PersonViewController ()<UITableViewDataSource,UITableViewDelegate,PostRequestToServerDelegate>

@end

@implementation PersonViewController
{
    PersonModel *per;
    UITableView *table;
    PostRequestToServer *personRequest;
    PostRequestToServer *tuichu;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"viewDidLoad");
//    [self getPersonInfo];
    [self initUI];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    NSLog(@"viewWillAppear");
    [self getPersonInfo];
    [table reloadData];
    
}
-(void)getPersonInfo
{
    personRequest=[[PostRequestToServer alloc]init];
    [personRequest getPersonInfo];
    personRequest.delegate=self;
}
-(void)initUI
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"个人信息";
    table=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    table.scrollEnabled=NO;
    
    [table registerNib:[UINib nibWithNibName:@"PersonFristTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellSelf"];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    foot.backgroundColor=[UIColor colorWithWhite:0.8 alpha:0.4];
    table.tableFooterView=foot;
    [self.view addSubview:table];
    
}
-(void)getPersonInfoSucceed:(ASIHTTPRequest *)request
{
  per = [MyJson getPerson:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]];
    NSLog(@"per======%@",per.nickName);
    [table reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 3;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }else{
        return 60;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head=[[UIView alloc]init];
    head.backgroundColor=[UIColor colorWithWhite:0.8 alpha:0.4];
    head.frame=CGRectMake(0, 0, SCREENWIDTH, 50);
    
    return head;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 100;
    }else{
        return 50;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        PersonFristTableViewCell *person=[tableView dequeueReusableCellWithIdentifier:@"cellSelf" forIndexPath:indexPath];
        person.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        NSString *str;
        person.label.text=@"个人信息";
        
        [person.image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/st%@",per.headerUrl]] placeholderImage:[UIImage imageNamed:@"head.png"]];

//        if (per.headerUrl!=nil) {
//            NSLog(@"!+333+++=====%@",per.headerUrl);
//            person.image.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/st%@",per.headerUrl]]]];
//        }
        return person;
        
    }else{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.font=[UIFont systemFontOfSize:28];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section==1) {
            if (indexPath.row==0) {
                
                cell.textLabel.text=@"清理图片缓存";
            }
            if (indexPath.row==1) {
                
                cell.textLabel.text=@"清理文件缓存";
            }
            if (indexPath.row==2) {
                
                cell.textLabel.text=@"退出登录";
            }
        } else {
            
                cell.textLabel.text=@"关于我们";
        }
      return cell;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [table deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section==0) {
        PersonMessageViewController *message=[[PersonMessageViewController alloc]init];
        message.per=per;
        [self.navigationController pushViewController:message animated:YES];
    }
    if (indexPath.section==1) {
        
        
        
        if (indexPath.row==2) {
            //退出登录
//            @"是否退出登录?"
//            @"退出"
            UIAlertController *alter=[UIAlertController alertControllerWithTitle:@"是否退出登录?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1=[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                tuichu=[[PostRequestToServer alloc]init];
                [tuichu tuiChu];
                tuichu .delegate=self;
            }];
            UIAlertAction *action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alter addAction:action1];
            [alter addAction:action2];
            [self presentViewController:alter animated:YES completion:nil];
            
        }
    }
    if (indexPath.section==2) {

        ONECHOOSEALTER(@"欢迎使用易聊");//宏定义alterViewController
    }
}
-(void)tuiChuSucceed:(ASIHTTPRequest *)request
{
   BOOL isok = [MyJson tuiChuJson:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]];
    if (isok) {
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"access_token"];//将存储到本地的access_token制空
        WelcomViewController *welcom=[[WelcomViewController alloc]init];
        [[UIApplication sharedApplication].delegate window].rootViewController=welcom;
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
