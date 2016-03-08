//
//  ChattingRoomViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ChattingRoomViewController.h"
#import "MySelfTableViewCell.h"
#import "FriendsTableViewCell.h"
#import "UsefulHeader.h"
@interface ChattingRoomViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,PostRequestToServerDelegate>

@end

@implementation ChattingRoomViewController
{
    PostRequestToServer *sentRequest;
    PostRequestToServer *chatQuest;
    UIView *myTextView;
    UITableView *table;
    NSMutableArray *chatArray;
    NSString *selfName;
    NSString *friendName;
    UITextField *field;
    ChatModel *currChat;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
    [self getChatMeaage];
}
-(void)initData
{
    selfName=_mySelf.name;
    friendName=_friends.name;
    chatArray=[[NSMutableArray alloc]init];
}
-(void)getChatMeaage
{
    chatQuest=[[PostRequestToServer alloc]init];
    [chatQuest getChatMessage];
    chatQuest.delegate=self;
}
-(void)initUI
{
    self.automaticallyAdjustsScrollViewInsets=YES;
    self.title=[NSString stringWithFormat:@"与%@聊天",self.friends.name];
    self.tabBarController.tabBar.hidden=YES;
    [self setMyTableView];
    [self setMyTextfieldView];
    
}
-(void)setMyTextfieldView
{
    myTextView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-60, SCREENWIDTH, 60)];
    myTextView.backgroundColor=[UIColor colorWithWhite:0.8 alpha:0.5];
    field=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, SCREENWIDTH-110, myTextView.frame.size.height-2*10)];
    field.borderStyle=UITextBorderStyleRoundedRect;
    field.delegate=self;
    [myTextView addSubview:field];
    UIButton *sent=[[UIButton alloc]initWithFrame:CGRectMake(field.frame.origin.x+field.frame.size.width+10, field.frame.origin.y, 80, field.frame.size.height)];
    [sent setTitle:@"发送" forState:UIControlStateNormal];
    sent.backgroundColor=[UIColor colorWithRed:0.2 green:0.3 blue:0.5 alpha:0.4];
    sent.layer.cornerRadius=4;
    sent.layer.masksToBounds=YES;
    [myTextView addSubview:sent];
    [sent addTarget:self action:@selector(sentMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myTextView];
}
-(void)setMyTableView{
    table=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    table.delegate=self;
    table.dataSource=self;
    [table registerNib:[UINib nibWithNibName:@"MySelfTableViewCell" bundle:nil] forCellReuseIdentifier:@"self"];
    [table registerNib:[UINib nibWithNibName:@"FriendsTableViewCell" bundle:nil] forCellReuseIdentifier:@"friend"];
    [self.view addSubview:table];

}
-(void)sentMessage:(UIButton *)butt
{
    NSLog(@"点击按钮");
    
    if (field.text!=nil) {
        [self getChatMeaage];//先请求聊天记录
    NSString *chatContent=field.text;
    NSDate *now=[NSDate date];
        sentRequest=[[PostRequestToServer alloc]init];
        [sentRequest sentChatWithName:_friends.name chat:[NSString stringWithFormat:@"%@|%@",[NSString changeDate:now],chatContent]];
        sentRequest.delegate=self;
       ChatModel *ch =[ChatModel createChatWithName:_friends.name chatContent:[NSString stringWithFormat:@"%@|%@",[NSString changeDate:now],chatContent] time:nil];
        currChat=ch;
        [chatArray addObject:currChat];
        [table reloadData];
        field.text=@"";
        [self.view endEditing:YES];
    }
    
    
}
#pragma mark==UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"开始编辑");
    [UIView animateWithDuration:0.3 animations:^{
         myTextView.frame=CGRectMake(0, SCREENHEIGHT-(60+216+60), SCREENWIDTH, 60);
    }];
   

}
//当编辑文本的时候，如果虚拟键盘挡住了textField，整个view就会向上移动。移动范围是一个键盘的高度216。
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"结束编辑");
    [UIView animateWithDuration:0.3 animations:^{
        myTextView.frame=CGRectMake(0, SCREENHEIGHT-60, SCREENWIDTH, 60);
    }];
    
    
    
}
#pragma mark==UITableViewDataSource,UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return chatArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   ChatModel *chat= chatArray[indexPath.row];
    if ([chat.friendName isEqualToString:_friends.name]) {
        NSLog(@"ziji!!!!");
        
         MySelfTableViewCell *myself=[tableView dequeueReusableCellWithIdentifier:@"self" forIndexPath:indexPath];
        myself.selectionStyle=UITableViewCellSelectionStyleNone;
        UIImage *ima= [UIImage imageNamed:@"bubbleSelf.png"];
//        [ima stretchableImageWithLeftCapWidth:9 topCapHeight:5];
        [ima resizableImageWithCapInsets:UIEdgeInsetsMake(10, 25, 10, 25) resizingMode:UIImageResizingModeStretch];
        myself.chatImage.image=ima;
        myself.headerImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/st%@",_mySelf.headerUrl]]]];
        myself.timeLabel.text=[chat.chatContent componentsSeparatedByString:@"|"][0];
        myself.chatLabel.text=[chat.chatContent componentsSeparatedByString:@"|"][1];
        return myself;
        
    }else {
        NSLog(@"bierere");
        FriendsTableViewCell *friend=[tableView dequeueReusableCellWithIdentifier:@"friend" forIndexPath:indexPath];
        friend.selectionStyle=UITableViewCellSelectionStyleNone;
        friend.imageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/st%@",_mySelf.headerUrl]]]];
        friend.timeLabel.text=[chat.chatContent componentsSeparatedByString:@"|"][0];
        friend.chatLabel.text=[chat.chatContent componentsSeparatedByString:@"|"][1];
        return friend;
    }
}
#pragma mark==PostRequestToServerDelegate
-(void)getChatMessageSucceed:(ASIHTTPRequest *)request
{
    [MyJson getChatMessage:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]];
    [table reloadData];
}
-(void)sentChatWithNameSucceed:(ASIHTTPRequest *)request
{
   BOOL isok= [MyJson sentChatMessage:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]];
    if (isok) {
//        [chatArray addObject:currChat];
        [self getChatMeaage];
//        [table reloadData];
    }
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
