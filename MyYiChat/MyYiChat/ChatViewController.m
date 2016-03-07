//
//  ChatViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTableViewCell.h"
#import "PostRequestToServer.h"
#import "MyJson.h"
#import "PersonModel.h"
#import "PersonMessageViewController.h"
#import "ChattingRoomViewController.h"
@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,PostRequestToServerDelegate>

@end

@implementation ChatViewController
{
    NSMutableArray *friendArray;
    UITableView *table;
    PostRequestToServer *friendsRequest;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
    
}
-(void)viewWillAppear:(BOOL)animated
{
[self getFriendsMessage];
    self.tabBarController.tabBar.hidden=NO;
}



-(void)initData
{
//    friendArray=[[NSMutableArray alloc]init];

}

-(void)initUI
{
    self.title=@"聊天中心";
    self.automaticallyAdjustsScrollViewInsets=YES;
    
    
    table=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.rowHeight=80;
    table.delegate=self;
    table.dataSource=self;
    [table registerNib:[UINib nibWithNibName:@"ChatTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:table];
}
-(void)getFriendsMessage
{
    friendsRequest=[[PostRequestToServer alloc]init];
    [friendsRequest getFriends];
    friendsRequest.delegate=self;
}
-(void)getFriendsSucceed:(ASIHTTPRequest *)request
{
//    [friendArray addObjectsFromArray:[MyJson getPersonArray:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]]];
    
   friendArray = [MyJson getPersonArray:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]];
    [table reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return friendArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   PersonModel *per= friendArray[indexPath.row];
    if (![per.headerUrl isEqualToString:@"null"]) {
        cell.headerImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/st%@",per.headerUrl]]]];
    }
    cell.headerButton.tag=indexPath.row;
    [cell.headerButton addTarget:self action:@selector(gotoPersonMessage:) forControlEvents:UIControlEventTouchUpInside];
    cell.contentLabel.text=@"心情不好";
    cell.nameLabel.text=per.name;
    if (indexPath.row==0) {
        cell.messageLabel.hidden=YES;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row==0) {
        [self gotoPersonMessage:nil];
    }else{
        ChattingRoomViewController *chat=[[ChattingRoomViewController alloc]init];
        chat.friends=friendArray[indexPath.row];
        chat.mySelf=friendArray[0];
        [self.navigationController pushViewController:chat animated:YES];
        
        
    }

}
//头像按钮绑定的方法
-(void)gotoPersonMessage:(UIButton *)butt
{
    NSLog(@"%ld",butt.tag);
    PersonMessageViewController *message=[[PersonMessageViewController alloc]init];
    message.per=friendArray[butt.tag];
    message.perTag=butt.tag;
    [self.navigationController pushViewController:message animated:YES];
    
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
