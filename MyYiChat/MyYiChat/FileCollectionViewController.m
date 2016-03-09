//
//  FileCollectionViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "FileCollectionViewController.h"
#import "UsefulHeader.h"
#import "MyCollectionViewCell.h"
#import "FileContentViewController.h"
@interface FileCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MyDownloadToolDelegate>

@end

@implementation FileCollectionViewController
{
    NSMutableDictionary *downloadDictionary;
    MyDownloadTool *download;
}
-(id)init
{
    if (self=[super init]) {
        //self.fileArray=[[NSMutableArray alloc]init];
        downloadDictionary=[[NSMutableDictionary alloc]init];
        
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
    return _fileArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    FileModel *file=_fileArray[indexPath.row];
    cell.nameLabel.text=file.name;
    cell.contentButton.file=file;
    [cell.contentButton setBackgroundImageWithURL:[NSURL URLWithString:file.image_url]];
    
    //先到本地地址查看该文件有没有下载过
    NSFileManager *manager=[NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:[NSString getPathOfDoucoment:[NSString stringWithFormat:@"file%@",file.tname]] isDirectory:nil]) {//如果已经在最终地址存放着就是
        cell.contentButton.buttonStatus=MyButtonDownloadSuccess;
        cell.contentButton.progress=1.0;
    }else if ([manager fileExistsAtPath:[NSString getPathOfDoucoment:[NSString stringWithFormat:@"temp%@",file.tname]] isDirectory:nil]){//如果在临时地址存放着
        
        
        long long size=[[[NSFileManager defaultManager]attributesOfItemAtPath:[NSString getPathOfDoucoment:[NSString stringWithFormat:@"temp%@",file.tname]] error:nil]fileSize];
        float pro= size/(float)file.length;
        NSLog(@"pro====%f",pro);
        cell.contentButton.progress=pro;
        
        MyDownloadTool *down=[downloadDictionary objectForKey:file.tname];
        
        if (!down) {//下载器字典中却没有该下载器，说明软件退出又进来,要显示继续下载
            NSLog(@"!!!");
            cell.contentButton.buttonStatus=MyButtonPauseStatus;
        }else{//下载器字典中却有该下载器，就说明是从本软件的某一个页面进到该页面，这样就要判断之前是正在下载还是暂停状态
            NSLog(@"000000");
            if ([down isDownloading]) {//正在下载==显示进度
            cell.contentButton.buttonStatus=MyButtonDownloadingStatus;
            }else{//暂停下载==继续下载
            
            cell.contentButton.buttonStatus=MyButtonPauseStatus;
            }
            
        
        }
    
    }else{//最终地址和临时地址都没
    
        cell.contentButton.buttonStatus=MyButtonDefaultStatus;
    }
    
    
    [cell.contentButton addTarget:self action:@selector(contentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
   
    return cell;
}

-(void)contentButtonClicked:(MyButton *)myButton
{
    //发请求下载文件
    NSLog(@"%@",myButton.file.name);
    //先到存放下载器的字典中查看是否有这个下载器
    if ([downloadDictionary objectForKey:myButton.file.tname]==nil) {//如果没有就是第一次点击按钮，那么就创建一个下载器，发请求下载，并将该下载器记录起来
        switch (myButton.buttonStatus) {
            case MyButtonDefaultStatus:
            case MyButtonPauseStatus:
                //
                download=[[MyDownloadTool alloc]init];
                [download starDownloadWithFile:myButton.file];
                [downloadDictionary setObject:download forKey:myButton.file.tname];
                break;
            case MyButtonDownloadSuccess:{
                FileContentViewController *content=[[FileContentViewController alloc]init];
                content.file=myButton.file;
                [self.navigationController pushViewController:content animated:YES];}
                break;

                
            default:
                break;
        }
        
        
        
    }else{//如果已经存在该下载器，再次点击就说明是暂停
        switch (myButton.buttonStatus) {
            case MyButtonDefaultStatus:
            case MyButtonPauseStatus:
                //
                [download starDownloadWithFile:myButton.file];
                [downloadDictionary setObject:download forKey:myButton.file.tname];
                break;
            case MyButtonDownloadingStatus:
                myButton.buttonStatus=MyButtonPauseStatus;
                [download stopDownload];
                break;
            case MyButtonDownloadSuccess:{
                FileContentViewController *content=[[FileContentViewController alloc]init];
                content.file=myButton.file;
                [self.navigationController pushViewController:content animated:YES];}
                break;
            default:
                break;
        }
        
    }
    
    
}
#pragma mark==MyDownloadToolDelegate
-(void)getProgress:(float)newProgress
{

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
