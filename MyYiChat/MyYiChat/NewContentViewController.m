//
//  NewContentViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "NewContentViewController.h"
#import "UsefulHeader.h"

@interface NewContentViewController ()<PostRequestToServerDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation NewContentViewController
{
    NSArray *totalArray;//总数组
//    NSArray *newsContentArray;//正文数组
//    NSArray *newsCommentArray;//评论数组
    UITableView *table;
    PostRequestToServer *requestContent;
    NewsModel *newsModel;
    NSMutableArray *contentArray;//包含评论【0】和正文【1】
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    [self getNewSContent];
}
-(void)viewWillAppear:(BOOL)animated
{
self.tabBarController.tabBar.hidden=NO;
}
-(void)initUI
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    NSLog(@"-======%@",self.news.source_url);
    self.title=_news.source;
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
    [self initLayout];//用SCrollView展示新闻详情
}
-(void)useTableViewShowNews
{
    table=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
//用SCrollView展示新闻详情
-(void)initLayout
{
    CGFloat scrollHeight=0;
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
//    scroll.pagingEnabled=YES;
    scroll.showsVerticalScrollIndicator=YES;
//    scroll.contentOffset=CGPointMake(0, 7*SpacingOfLine);
//    scroll.bounces=NO;
    scroll.contentSize=CGSizeMake(SCREENWIDTH, MAXFLOAT);
    [self.view addSubview:scroll];
    
    
    //设置新闻标题的尺寸
    UILabel *title=[[UILabel alloc]init];
    CGFloat titleX=SPACINGMINI;
    CGFloat titleY=SpacingOfLine;
    CGSize titleSiez=[_news.news_title sizeWithFont:TITLEFONT constrainedToSize:CGSizeMake(SCREENWIDTH-2*SPACINGMINI, MAXFLOAT)];
    title.frame=(CGRect){{titleX,titleY},titleSiez};
    title.numberOfLines=0;
    [scroll addSubview:title];
    title.font=TITLEFONT;
    title.text=_news.news_title;
    
    //设置来源的尺寸
    UILabel *source=[[UILabel alloc]init];
    CGFloat sourceX=titleX;
    CGFloat sourceY=CGRectGetMaxY(title.frame)+SPACINGMINI;
    CGSize sourceSize=[self.title sizeWithFont:TITLEFONT constrainedToSize:CGSizeMake(SCREENWIDTH-2*SPACINGMINI, MAXFLOAT)];
    source.frame=(CGRect){{sourceX,sourceY},sourceSize};
    [scroll addSubview:source];
    source.font=TIMEFONT;
    source.text=self.title;
    
    //设置作者chicun
    UILabel *author=[[UILabel alloc]init];
    author.numberOfLines=0;
    CGFloat authorX=CGRectGetMaxX(source.frame)+SPACINGMINI;
    CGFloat authorY=CGRectGetMaxY(title.frame)+SPACINGMINI;
    NSString *string=[NSString stringWithFormat:@"%@ %@/文",_news.source,_news.auther];
    CGSize authorSize=[string sizeWithFont:TITLEFONT constrainedToSize:CGSizeMake(SCREENWIDTH*0.5-2*SPACINGMINI, MAXFLOAT)];
    author.frame=(CGRect){{authorX,authorY},authorSize};
    [scroll addSubview:author];
    source.font=TIMEFONT;
    source.text=string;
    
    
    //设置时间的Frame
    UILabel *time=[[UILabel alloc]init];
    CGFloat timeX=CGRectGetMaxX(author.frame)+SpacingOfLine;
    CGFloat timeY=authorY;
    CGSize timeSize=[_news.time sizeWithFont:TIMEFONT];
    time.frame=(CGRect){{timeX,timeY},timeSize};
    [scroll addSubview:time];
    time.font=TIMEFONT;
    time.text=_news.time;
    
    //设置摘要视图的Frame
    UIView *infoView=[[UIView alloc]init];
    CGFloat infoViewX=0;
    CGFloat infoViewY=CGRectGetMaxY(source.frame)+SpacingOfLine;
    //设置摘要的Frame
    UILabel *info=[[UILabel alloc]init];
    info.numberOfLines=0;
    CGFloat infoX=titleX;
    CGFloat infoY=titleY;
    CGSize infoSize=[_news.intro sizeWithFont:CONTENTFONT constrainedToSize:CGSizeMake(SCREENWIDTH-2*SPACINGMINI, MAXFLOAT)];
    info.frame=(CGRect){{infoX,infoY},infoSize};
    CGFloat infoViewWidth=SCREENWIDTH;
    CGFloat infoViewHeight=infoSize.height+2*SPACINGMINI;
    infoView.frame=CGRectMake(infoViewX, infoViewY, infoViewWidth, infoViewHeight);
    infoView.backgroundColor=[UIColor grayColor];
    [scroll addSubview:infoView];
    [infoView addSubview:info];
    info.font=CONTENTFONT;
    info.text=_news.intro;
    
    
    //图文
    NSArray *data=contentArray[1];
    CGFloat contentHeight=0;
    for (NSDictionary *contentDict in data) {
        NSString *data_type=[contentDict objectForKey:@"data_type"];
        if ([data_type intValue]==1) {//正文
            NSString *content=[contentDict objectForKey:@"content"];
            
            if (content!=nil) {
                
                
                NSLog(@"正文=====%lf",contentHeight);
                UILabel *contentLabel=[[UILabel alloc]init];
                contentLabel.numberOfLines=0;
                CGFloat contentLabelX=SPACINGMINI;
                CGFloat contentLabelY=contentHeight+CGRectGetMaxY(infoView.frame);
                CGSize contentLabelSize=[content sizeWithFont:CONTENTFONT constrainedToSize:CGSizeMake(SCREENWIDTH-2*SPACINGMINI, MAXFLOAT)];
                contentLabel.frame=(CGRect){{contentLabelX,contentLabelY},contentLabelSize};
                [scroll addSubview:contentLabel];
                contentLabel.text=content;
                contentHeight=CGRectGetMaxY(contentLabel.frame)+SpacingOfLine;
               NSLog(@"正文==%lf+10===%lf",CGRectGetMaxY(contentLabel.frame),contentHeight);
                NSLog(@"正文=======%@",NSStringFromCGRect(contentLabel.frame));
            }
            
            
        }
        if ([data_type intValue]==2) {//图片
             NSLog(@"图片=====%lf",contentHeight);
            NSDictionary *imageDic=[contentDict objectForKey:@"image"];
            NSString *picUrl=[imageDic objectForKey:@"source"];
            if (picUrl!=nil) {
                UIImageView *contentImage=[[UIImageView alloc]init];
                NSString *height=[imageDic objectForKey:@"height"];
                NSString *width=[imageDic objectForKey:@"width"];
                CGFloat contentImageX=SPACINGMINI;
                CGFloat contentImageY=contentHeight+CGRectGetMaxY(infoView.frame);
                contentImage.frame=CGRectMake(contentImageX, contentImageY, [width floatValue], [height floatValue]);
                [scroll addSubview:contentImage];
                contentImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",picUrl]]]];
                contentHeight=CGRectGetMaxY(contentImage.frame)+SpacingOfLine;
                NSLog(@"图片============%@",NSStringFromCGRect(contentImage.frame));
            }
        }
    }
    //帖子标题
    UILabel *commtentTitle=[[UILabel alloc]init];
    CGFloat commentTitleX=titleX;
    CGFloat commentTitleY=contentHeight+1*SpacingOfLine;
    NSString *str=@"热门跟帖";
    CGSize commenttitleSize=[str sizeWithFont:TITLEFONT];
    commtentTitle.frame=(CGRect){{commentTitleX,commentTitleY},commenttitleSize};
    [scroll addSubview:commtentTitle];
    commtentTitle.font=TITLEFONT;
    commtentTitle.text=str;
    //帖子作者、内容
    CGFloat commentHeight=0;
    
    NSArray *comments=contentArray[0];

    for (NSDictionary *dict in comments) {
        NSString *infoContent=[dict objectForKey:@"info"];//帖子内容
        NSString *name=[dict objectForKey:@"name"];//帖子作者
       
        UILabel *nameL=[[UILabel alloc]init];
        CGFloat nameX=titleX;
        CGFloat nameY=CGRectGetMaxY(commtentTitle.frame)+SpacingOfLine*2+commentHeight;
        CGSize nameSize=[name sizeWithFont:TIMEFONT];
        nameL.frame=(CGRect){{nameX,nameY},nameSize};
        [scroll addSubview:nameL];
        nameL.font=TIMEFONT;
        nameL.textColor=[UIColor blueColor];
        nameL.text=name;
        
        UILabel *infoContentL=[[UILabel alloc]init];
        infoContentL.numberOfLines=0;
        CGFloat infoContentX=titleX;
        CGFloat infoContentY=CGRectGetMaxY(nameL.frame)+SPACINGMINI;
        CGSize infoContentSiez=[infoContent sizeWithFont:CONTENTFONT constrainedToSize:CGSizeMake(SCREENWIDTH-2*SPACINGMINI, MAXFLOAT)];
        infoContentL.frame=(CGRect){{infoContentX,infoContentY},infoContentSiez};
        [scroll addSubview:infoContentL];
        infoContentL.font=CONTENTFONT;
        infoContentL.text=infoContent;
        
        commentHeight=CGRectGetMaxY(infoContentL.frame)+SpacingOfLine;
        scrollHeight=CGRectGetMaxY(infoContentL.frame)+3*SpacingOfLine;
    }
    scroll.contentSize=CGSizeMake(SCREENWIDTH, scrollHeight);

}
#pragma mark===TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 0;
    }
    return 0;
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
