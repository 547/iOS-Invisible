//
//  DownloadedFilesViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/9.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "DownloadedFilesViewController.h"
#import "UsefulHeader.h"
#import "OneImageTableViewCell.h"
#import "SDImageCache.h"
#import "FileContentViewController.h"
@interface DownloadedFilesViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DownloadedFilesViewController
{
    
    UITableView *table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}
-(void)initUI
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"本地文件";
    [self createTableView];
}
-(void)createTableView
{
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 64,SCREENWIDTH , SCREENHEIGHT-64-49) style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=100;
    [table registerNib:[UINib nibWithNibName:@"OneImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellOne"];
    [self.view addSubview:table];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneImageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellOne" forIndexPath:indexPath];
    FileModel *file=_tableArray[indexPath.row];
    [cell.imageNew setImageWithURL:[NSURL URLWithString:file.image_url]];
    cell.titleNew.text=file.name;
    cell.contentNew.text=file.fileDescription;
    cell.sourceNew.textColor=[UIColor blueColor];
    cell.sourceNew.text=[NSString stringWithFormat:@"%0.2fM",(float)[self sizeFormatterWithByte:file.length]];
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FileModel *file=_tableArray[indexPath.row];
    //删除本地文件
    [[NSFileManager defaultManager]removeItemAtPath:[NSString getPathOfDoucoment:[NSString stringWithFormat:@"file%@",file.tname]] error:nil];
    //删除数组
    [_tableArray removeObject:file];
    //删除单元格
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    FileModel *file=_tableArray[indexPath.row];
    FileContentViewController *content=[[FileContentViewController alloc]init];
    content.file=file;
    [self.navigationController pushViewController:content animated:YES];
}

//大小转换器
-(float)sizeFormatterWithByte:(long long)byte;
{
    float length=(float)byte;
    return length/1024.0/1024.0;
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
