//
//  PersonMessageViewController.h
//  MyYiChat
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"
@interface PersonMessageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UITextField *nickNameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
- (IBAction)changed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *change;
@property (weak, nonatomic) IBOutlet UILabel *alter;
@property(nonatomic,strong)PersonModel *per;
@property(nonatomic,assign)NSInteger perTag;
@end
