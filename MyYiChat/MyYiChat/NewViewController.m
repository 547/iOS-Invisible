//
//  NewViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "NewViewController.h"
#import "UsefulHeader.h"
#import "OneImageTableViewCell.h"
#import "NewsModel.h"
#import "ThreeImageTableViewCell.h"
#import "NewNewsContentViewController.h"
#import "NewContentViewController.h"
@interface NewViewController ()<PostRequestToServerDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation NewViewController
{
    PostRequestToServer *newRequest;
    NSMutableArray *newArray;
    UITableView *table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self postRequestNews];
}
-(void)viewWillAppear:(BOOL)animated
{
self.tabBarController.tabBar.hidden=NO;
}
-(void)initUI
{
    self.title=@"新闻中心";
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];

    table.delegate=self;
    table.dataSource=self;
    table.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];

  UINib *threeNib = [UINib nibWithNibName:@"ThreeImageTableViewCell" bundle:nil];
    UINib *oneNib=[UINib nibWithNibName:@"OneImageTableViewCell" bundle:nil];
    [table registerNib:oneNib forCellReuseIdentifier:@"cellOne"];
    [table registerNib:threeNib forCellReuseIdentifier:@"cellSecond"];

   
    
    
}
-(void)postRequestNews
{
    newRequest=[[PostRequestToServer alloc]init];
    [newRequest getNews];
    newRequest.delegate=self;
}
#pragma mask==PostRequestToServerDelegate

-(void)getNewsSucceed:(ASIHTTPRequest *)request
{
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
   
    newArray=[MyJson newsJson:dic];
    [table reloadData];
}

#pragma mask==UITableViewDelegate,UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *news=[newArray objectAtIndex:indexPath.row];
    if (news.images.count>=2) {
        return 120;
    }else{
        return 100;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *news=[newArray objectAtIndex:indexPath.row];
    

    if (news.images.count>2) {
        
    
        
        ThreeImageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellSecond" forIndexPath:indexPath];
        
        cell.titleNew.text=news.news_title;
        cell.sourceNew.text=news.source;
    
        for (int i=0; i<cell.imageArray.count; i++) {
//            UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",[news.images[i] objectForKey:@"url"]]]]];
            
            
            UIImageView *imageView=cell.imageArray[i];
//            imageView.image=image;
            
            [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",[news.images[i] objectForKey:@"url"]]]];
            
            
        }
        return cell;
    }else{
        
        
        OneImageTableViewCell *cellOne=[tableView dequeueReusableCellWithIdentifier:@"cellOne" forIndexPath:indexPath];
        
        [cellOne.imageNew setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",[news.images[0] objectForKey:@"url"]]]];
        
        
//        
//        cellOne.imageNew.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",[news.images[0] objectForKey:@"url"]]]]];

        cellOne.titleNew.text=news.news_title;
        cellOne.contentNew.text=news.intro;
        cellOne.sourceNew.text=news.source;
        return cellOne;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    NewContentViewController *newContent=[[NewContentViewController alloc]init];
//    newContent.news=[newArray objectAtIndex:indexPath.row];
    NewNewsContentViewController *newContent=[[NewNewsContentViewController alloc]init];
    newContent.news=[newArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:newContent animated:YES];
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
