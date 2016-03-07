//
//  FilesViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "FilesViewController.h"
#import "UsefulHeader.h"
#import "MyCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#define loyoutWidth 100
@interface FilesViewController ()<PostRequestToServerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,MyCollectionViewCellDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,ASIProgressDelegate>

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
-(void)initUI
{
    self.navigationController.navigationBar.hidden=YES;
    [self setTopView];
    [self setMiddleView];

}
-(void)setTopView
{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    topView.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.05];
    [self.view addSubview:topView];
    segment=[[UISegmentedControl alloc]initWithItems:@[@"公共资源",@"个人资源"]];
    segment.center=topView.center;
    segment.bounds=CGRectMake(0, 0, SCREENWIDTH/3, 64*0.5);
    segment.selectedSegmentIndex=0;
    [segment addTarget:self action:@selector(cheakSegment:) forControlEvents:UIControlEventValueChanged];
    [topView addSubview:segment];
}
-(void)setMiddleView
{
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 65, SCREENWIDTH, SCREENHEIGHT-65)];
    scroll.tag=3;
    scroll.delegate=self;
    scroll.pagingEnabled=YES;
    scroll.alwaysBounceHorizontal=YES;
//    scroll.backgroundColor=[UIColor redColor];
    scroll.contentSize=CGSizeMake(2*SCREENWIDTH, scroll.frame.size.height);
    [self.view addSubview:scroll];
    
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
    collection.alwaysBounceVertical=NO;
    collection.alwaysBounceHorizontal=YES;
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
    [cell.mainImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",file.image_url]]];
    if (file.isDownload) {
        
        //
        
        
        //半透明的label做下载进度条，其高度随下载进度变化
        CGFloat x=cell.viewLabel.frame.origin.x;
        CGFloat height=cell.mainImage.frame.size.height*currentProgress;
        cell.viewLabel.frame=CGRectMake(x, height, cell.viewLabel.frame.size.width, height);

    }
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FileModel *file=nil;
    if (collectionView.tag==1) {
    file=fileLeftArray[indexPath.row];
    }else{
    file=fileRightArray[indexPath.row];
    }
    file.isDownload=YES;
    //下载
    downLoadRequest=[[PostRequestToServer alloc]init];
    [downLoadRequest downLoadFileWitnUrl:file.url];
    downLoadRequest.progressDelegate=self;
    
}
-(void)setProgress:(float)newProgress
{
    currentProgress=newProgress;
    NSLog(@"当前的进度：%0.2f",newProgress);
}
-(void)getFileMessgeSucceed:(ASIHTTPRequest *)request
{
   fileLeftArray= [MyJson getPersonFileMessage:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]];
    fileRightArray= [MyJson getPublicFileMessage:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]];
    [collectionLeft reloadData];
    [collectionRight reloadData];
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
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;

    
    
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
