//
//  PersonMessageViewController.m
//  MyYiChat
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "PersonMessageViewController.h"
#import "UsefulHeader.h"
@interface PersonMessageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,PostRequestToServerDelegate>

@end

@implementation PersonMessageViewController
{
    PostRequestToServer *changeMaessage;
    PostRequestToServer *hesderImageRequest;
    UIImage *im;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
-(void)initUI
{
//    NSLog(@"%@",_per.name);
    self.title=@"个人信息";
    if (_perTag!=0) {
       //好友
        self.nickNameText.userInteractionEnabled=NO;
        self.emailText.userInteractionEnabled=NO;//让TextField不可编辑
        self.change.hidden=YES;
    }else{
        //自己
        UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"上传头像" style:UIBarButtonItemStylePlain target:self action:@selector(selectImage)];
        
        self.navigationItem.rightBarButtonItem=right;

        [self.nickNameText addTarget:self action:@selector(changeButton) forControlEvents:UIControlEventEditingChanged];
        [self.emailText addTarget:self action:@selector(changeButton) forControlEvents:UIControlEventEditingChanged];
        [self.nickNameText addTarget:self action:@selector(huiFuButton) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self.emailText addTarget:self action:@selector(huiFuButton) forControlEvents:UIControlEventEditingDidEndOnExit];
        self.change.userInteractionEnabled=NO;//不可点击,交互性
        self.change.layer.cornerRadius=6;
        self.change.layer.masksToBounds=YES;

    }
    
    self.headerImage.layer.cornerRadius=6;
    self.headerImage.layer.masksToBounds=YES;

    [self.headerImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURLHEAD,_per.headerUrl]] placeholderImage:[UIImage imageNamed:@"head.png"]];
    
//    if (![_per.headerUrl isEqualToString:@"null"]) {
//        NSLog(@"!!!!!++++%@",_per.headerUrl);
//        self.headerImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/st%@",_per.headerUrl]]]];
//    }else{
//        
//        self.headerImage.image=[UIImage imageNamed:@"head.png"];
//    }
    self.nameLabel.text=_per.name;
    self.nickNameText.text=_per.nickName;
    self.emailText.text=_per.email;


    
}
-(void)huiFuButton
{
    self.change.userInteractionEnabled=NO;
    self.change.backgroundColor=[UIColor grayColor];
    [self.change setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.change addTarget:self action:@selector(noChange) forControlEvents:UIControlEventTouchUpInside];
}
-(void)noChange
{

}
-(void)changeButton
{
  self.change.userInteractionEnabled=YES;
    self.change.backgroundColor=[UIColor blueColor];
    [self.change setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.change addTarget:self action:@selector(changed:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)selectImage
{
//    NSLog(@"dainji");
    UIImagePickerController *pick=[[UIImagePickerController alloc]init];
    pick.allowsEditing=YES;
    pick.allowsImageEditing=YES;
    pick.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    pick.delegate=self;
    [self presentViewController:pick animated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    NSLog(@"选中图片==%@",info);

    im=[info objectForKey:@"UIImagePickerControllerEditedImage"];//可以剪切图片

    [self dismissViewControllerAnimated:YES completion:^{
        hesderImageRequest=[[PostRequestToServer alloc]init];
        [hesderImageRequest uploadHeaderImage:im];
        hesderImageRequest.delegate=self;

    }];

    
}
-(void)uploadHeaderImageSucceed:(ASIHTTPRequest *)request
{
  BOOL isok = [MyJson uploadHeaderImage:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]];
    if (isok) {
        _headerImage.image=im;
        
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changed:(UIButton *)sender {
    
    if ([NSString trim:self.nickNameText.text]==nil||[NSString trim:self.emailText.text]==nil) {
        self.alter.text=@"昵称或邮箱不能为空";
        return;
    }
    if ([[NSString trim:self.nickNameText.text]isEqualToString:_per.nickName]&&[[NSString trim:self.emailText.text]isEqualToString:_per.email]) {
        self.alter.text=@"还没有修改信息";
        return;
    }else
    {
    self.alter.text=@"";
    }
    NSLog(@"nick====%@,emial===%@",self.nickNameText.text,self.emailText.text);
    changeMaessage=[[PostRequestToServer alloc]init];
    [changeMaessage changePersonMessageLikeNickName:self.nickNameText.text email:self.emailText.text];
    changeMaessage.delegate=self;
}
-(void)changePersonMessageSucceed:(ASIHTTPRequest *)request
{
    BOOL isok=[MyJson changeMessage:[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil]];
    if (isok) {
        _per.nickName=self.nickNameText.text;
        _per.email=self.emailText.text;
        
        [self huiFuButton];
    }
}
@end
