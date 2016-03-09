//
//  FilesViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "FilesViewController.h"
#import "UsefulHeader.h"
#import "FileContentViewController.h"
#import "FileCollectionViewController.h"
#import "MyCollectionViewCell.h"
@interface FilesViewController ()<PostRequestToServerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,ASIProgressDelegate>

@end

@implementation FilesViewController
{
    float currentProgress;
    UIScrollView *scroll;
    UICollectionView *collectionRight;
    PostRequestToServer *fileRequest;
    PostRequestToServer *downLoadRequest;
    UISegmentedControl *segment;
    NSMutableArray *fileLeftArray;
    NSMutableArray *fileRightArray;
    UICollectionView *collectionLeft;
    int tag;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self getFileMessage];
    
}
-(void)getFileMessage
{
    fileRequest=[[PostRequestToServer alloc]init];
    [fileRequest getFileMessge];
    fileRequest.delegate=self;
    
    
    
}
-(void)getFileMessgeSucceed:(ASIHTTPRequest *)request
{
    fileLeftArray= [MyJson getPersonFileMessage:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]];
    fileRightArray= [MyJson getPublicFileMessage:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]];
    for (int i=0; i<2; i++) {
        
        FileCollectionViewController *fileVC=[[FileCollectionViewController alloc]init];
        fileVC.view.frame=CGRectMake(SCREENWIDTH*i, 0, SCREENWIDTH, scroll.frame.size.height-49);
        if (i==0) {
            fileVC.fileArray=fileRightArray;
        }else{
            fileVC.fileArray=fileLeftArray;
        }
        NSLog(@"========%lu",(unsigned long)fileVC.fileArray.count);
        [scroll addSubview:fileVC.view];
        [self addChildViewController:fileVC];
    }
    
    //    [collectionLeft reloadData];
    //    [collectionRight reloadData];
    
}

-(void)initUI
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self setTopView];
    [self setMiddleView];

}
-(void)setTopView
{
//    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
//    topView.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.05];
//    [self.view addSubview:topView];
    
    segment=[[UISegmentedControl alloc]initWithItems:@[@"公共资源",@"个人资源"]];
    self.navigationItem.titleView=segment;
    segment.center=self.navigationItem.titleView.center;
//    segment.center=topView.center;
    segment.bounds=CGRectMake(0, 0, SCREENWIDTH/3, 64*0.5);
    segment.selectedSegmentIndex=0;
    [segment addTarget:self action:@selector(cheakSegment:) forControlEvents:UIControlEventValueChanged];
   //    [topView addSubview:segment];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"download_button.png"] style:UIBarButtonItemStyleDone target:self action:@selector(goToDownloadedViewControll)];
    self.navigationItem.rightBarButtonItem=right;
}
-(void)setMiddleView
{
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
    scroll.tag=3;
    scroll.delegate=self;
    scroll.pagingEnabled=YES;
//    scroll.alwaysBounceVertical=NO;
//    scroll.alwaysBounceHorizontal=YES;
    scroll.contentSize=CGSizeMake(2*SCREENWIDTH, scroll.frame.size.height);
    [self.view addSubview:scroll];
    
//    [self addSubViewToScroll];
    
    NSLog(@"%@",fileLeftArray);
    
    
    
}
-(void)addSubViewToScroll
{
    collectionLeft = [self createCollectionViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, scroll.frame.size.height)];
    [scroll addSubview:collectionLeft];
    collectionLeft.tag=1;
    
    collectionRight = [self createCollectionViewWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, scroll.frame.size.height)];
    [scroll addSubview:collectionRight];
    collectionRight.tag=2;
}
-(UICollectionView *)createCollectionViewWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layou=[[UICollectionViewFlowLayout alloc]init];
    layou.sectionInset=UIEdgeInsetsMake(20, 20, 30, 20);
    layou.minimumInteritemSpacing=20;
    layou.minimumLineSpacing=30;
    layou.itemSize=CGSizeMake(loyoutWidth, loyoutWidth);
    layou.scrollDirection=UICollectionViewScrollDirectionVertical;
    UICollectionView *collection=[[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layou];

    collection.backgroundColor=[UIColor whiteColor];
    [collection registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    collection.pagingEnabled=YES;
    collection.delegate=self;
    collection.dataSource=self;
    
    return collection;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    if (scrollView.tag==3) {
        if (scrollView.contentOffset.x>=SCREENWIDTH) {
            segment.selectedSegmentIndex=1;
        }else
        {
            segment.selectedSegmentIndex=0;
        }
    }

    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag==1) {
    return fileLeftArray.count;
    }else{
    return fileRightArray.count;
    }
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FileModel *file=nil;
     MyCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (collectionView.tag==1) {
        file=fileLeftArray[indexPath.row];
        
    }else{
        file=fileRightArray[indexPath.row];
    }
   
    cell.nameLabel.adjustsFontSizeToFitWidth=YES;
    cell.nameLabel.text=file.name;
//    [cell.mainImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",file.image_url]]];
//    if (file.isDownload) {
        
        //
//        cell.centerLabel.text=[NSString stringWithFormat:@"%0.2f%@",currentProgress*100,@"%"];
//        //半透明的label做下载进度条，其高度随下载进度变化
//        CGFloat x=cell.viewLabel.frame.origin.x;
//        CGFloat height=cell.mainImage.frame.size.height*currentProgress;
//        cell.viewLabel.frame=CGRectMake(x, height, cell.viewLabel.frame.size.width, height);
//        if (currentProgress==1.0) {
//            cell.centerLabel.text=@"查看";
//            file.downloaded=YES;
//            cell.viewLabel.hidden=YES;
//        }
    

//    }
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    FileModel *file=nil;
    if (collectionView.tag==1) {
    file=fileLeftArray[indexPath.row];
        tag=1;
    }else{
    file=fileRightArray[indexPath.row];
        tag=2;
    }
    NSLog(@"%@",file.url);
    downLoadRequest=[[PostRequestToServer alloc]init];

    if (file.isDownload) {
        [downLoadRequest stopDownload];
//        downLoadRequest 
    }else{
        file.isDownload=YES;
               [downLoadRequest downLoadFileWitnUrl:file.url name:file.tname];
        downLoadRequest.delegate=self;
    
    }
    if (file.downloaded) {//已经下载完
        FileContentViewController *fileVC=[[FileContentViewController alloc]init];
        fileVC.file=file;
        [self.navigationController pushViewController:fileVC animated:YES];
        
    }
    
    
}
-(void)downLoadFileWitnUrlProgress:(float)newProgress
{
    currentProgress=newProgress;
    NSLog(@"当前的进度：%0.2f",newProgress);
    if (tag==1) {
        [collectionLeft reloadData];
    }
    if (tag==2) {
        [collectionRight reloadData];
    }

}

//点击选项卡UISegmentedControl
-(void)cheakSegment:(UISegmentedControl *)se
{
    NSLog(@"+++%ld",se.selectedSegmentIndex);
    if (se.selectedSegmentIndex==0) {
//        coll.contentOffset=CGPointMake(0, 0);
        scroll.contentOffset=CGPointMake(0, 0);
    }else{
//        coll.contentOffset=CGPointMake(SCREENWIDTH, 0);
        scroll.contentOffset=CGPointMake(SCREENWIDTH, 0);
        ;
    }
    
}
-(void)goToDownloadedViewControll
{
    NSLog(@"fdsfds");
}
-(void)viewWillAppear:(BOOL)animated
{
   
    self.tabBarController.tabBar.hidden=NO;
//    self.navigationController.navigationBar.hidden=YES;
    
    
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
