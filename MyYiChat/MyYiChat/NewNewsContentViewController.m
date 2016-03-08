//
//  NewNewsContentViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "NewNewsContentViewController.h"
#import "UsefulHeader.h"
@interface NewNewsContentViewController ()<UITableViewDataSource,UITableViewDelegate,PostRequestToServerDelegate>

@end

@implementation NewNewsContentViewController
{
    PostRequestToServer *requestContent;    UITableView *table;
    NSMutableArray *contentArray;//包含评论【0】和正文【1】
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getNewSContent];
    [self initUI];
}

-(void)initUI
{
    table=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)getNewSContent
{
    requestContent=[[PostRequestToServer alloc]init];
    [requestContent getNewsContent:_news.source_url];
    requestContent.delegate=self;
    
}
#pragma mask==PostRequestToServerDelegate
-(void)getNewsContentSucceed:(ASIHTTPRequest *)request
{
    contentArray=[MyJson getNewsContentJson:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]];
    [table reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    /*
     1.1标题+来源+作者+时间 1.2.摘要
     2.正文==文字+图片
     3.热门评论
     4.评论内容
     */
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else if (section==1) {
        return 0;
    }else{
        return 0;
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
