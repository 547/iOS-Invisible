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
    
    self.title=_news.source;
    self.automaticallyAdjustsScrollViewInsets=NO;
    //这里table的Frame不可以偷懒直接设成self.view.frame，要自己重新设置过，64=导航的头高，49是tabbar的高
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64-49) style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    table.separatorStyle=UITableViewCellSeparatorStyleNone;
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
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
    _news=[NewsModel createNewsWith:dic news:_news];
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
    if (section==0) {//1.1标题+来源+作者+时间 1.2.摘要
        return 2;
    }else if (section==1) {//2.正文==文字+图片
        return _news.contentArray.count;
    }else if(section==2){//3.热门评论
        return 1;
    }else{//4.评论内容
        return _news.commentArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {//1.1标题+来源+作者+时间 1.2.摘要
        return [self getRowHeightWithString:_news.news_title font:TITLEFONT]+[self getRowHeightWithString:[NSString stringWithFormat:@"%@   %@/文   %@",_news.source,_news.auther,_news.time] font:TITLEFONT]+20;
        }else{//摘要
            return [self getRowHeightWithString:_news.intro font:CONTENTFONT]+20;
        }
        }else if (indexPath.section==1){
        NewsContentModel *content=_news.contentArray[indexPath.row];
        if ([content.data_type intValue]==1) {//文字
            return [self getRowHeightWithString:content.newsContent font:TITLEFONT]+20;
        }else{//图片
            return [content.height intValue]+20;
        }
        }else if (indexPath.section==2){
        return [self getRowHeightWithString:@"热门评论" font:CONTENTFONT]+20;
        }else{//评论
            NewsCommentModel *comment=_news.commentArray[indexPath.row];
        return [self getRowHeightWithString:comment.author font:TIMEFONT]+[self getRowHeightWithString:comment.content font:CONTENTFONT]+20;
        }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    //为避免cell重用，导致内容错乱，cell在使用之前先将其清空
     cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.numberOfLines=0;
    cell.textLabel.font=SYSTEMFONT;
    cell.textLabel.text=nil;
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.imageView.image=nil;
    cell.detailTextLabel.numberOfLines=0;
    cell.detailTextLabel.textColor=[UIColor blackColor];
    cell.detailTextLabel.text=nil;
    
    cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell = [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            cell.textLabel.font=TITLEFONT;
            cell.textLabel.numberOfLines=0;
            cell.textLabel.text=_news.news_title;
            cell.detailTextLabel.font=TIMEFONT;
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@   %@/文   %@",_news.source,_news.auther,_news.time];
        } else {//摘要
            cell.backgroundColor=[UIColor grayColor];
            cell.textLabel.font=CONTENTFONT;
            cell.textLabel.numberOfLines=0;
            cell.textLabel.text=_news.intro;
        }
        
    }else if (indexPath.section==1){//正文
      NewsContentModel *content=  _news.contentArray[indexPath.row];
        if ([content.data_type intValue]==1) {//文字
            cell.textLabel.font=CONTENTFONT;
            cell.textLabel.numberOfLines=0;
            cell.textLabel.text=content.newsContent;
        }else{//图片
            
            [cell.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",content.url]]];
            NSLog(@"%@",content.url);
        
        }
        
    }else if (indexPath.section==2){
        cell.textLabel.font=CONTENTFONT;
        cell.textLabel.text=@"热门评论";
    }else{
       cell = [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        NewsCommentModel *comment=_news.commentArray[indexPath.row];
        cell.textLabel.font=TIMEFONT;
        cell.textLabel.numberOfLines=0;
        cell.textLabel.textColor=[UIColor blueColor];
        cell.textLabel.text=comment.author;
        
        cell.detailTextLabel.font=CONTENTFONT;
        cell.detailTextLabel.numberOfLines=0;
        cell.detailTextLabel.text=comment.content;
    }
    return cell;
}






//求高
-(CGFloat)getRowHeightWithString:(NSString *)str font:(UIFont *)font
{
    //定宽求高，定高求宽==options=NSStringDrawingUsesLineFragmentOrigin===PS：必须填这个属性
  CGRect rect =  [str boundingRectWithSize:CGSizeMake(SCREENWIDTH-2*SpacingOfLine, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceilf(rect.size.height);
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
