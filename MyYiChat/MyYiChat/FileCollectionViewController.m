//
//  FileCollectionViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "FileCollectionViewController.h"
#import "UsefulHeader.h"

@interface FileCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation FileCollectionViewController
-(id)initWithArray:(NSMutableArray *)array
{
    if (self=[super init]) {
        self.fileArray=[[NSMutableArray alloc]initWithCapacity:array.count];
    
        self.fileArray=array;
    }
    return self;
}
-(id)init
{
    if (self=[super init]) {
        //self.fileArray=[[NSMutableArray alloc]init];
        
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void)viewWillAppear:(BOOL)animated
{
[self initUI];
}
-(void)initUI
{
    NSLog(@"-----------%lu",(unsigned long)_fileArray.count);
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    
    layout.sectionInset=UIEdgeInsetsMake(20, 20, 30, 20);
    layout.minimumInteritemSpacing=20;
    layout.minimumLineSpacing=30;
    layout.itemSize=CGSizeMake(loyoutWidth, loyoutWidth);
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    UICollectionView *collection=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collection.backgroundColor=[UIColor whiteColor];
    [collection registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    collection.pagingEnabled=YES;
    collection.delegate=self;
    collection.dataSource=self;
    [collection registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collection];
}
#pragma mark===UICollectionViewDataSource,UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    FileModel *file=_fileArray[indexPath.row];
    cell.contentButton.file=file;
    [cell.contentButton setBackgroundImageWithURL:[NSURL URLWithString:file.url]];
    [cell.contentButton addTarget:self action:@selector(contentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)contentButtonClicked:(MyButton *)myButton
{
    //发请求下载文件
    
    NSLog(@"%@",myButton.file.name);
    
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
