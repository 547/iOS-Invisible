//
//  MySelfTableViewCell.h
//  MyYiChat
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
@interface MySelfTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chatImage;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIButton *headerButton;
@property (weak, nonatomic) IBOutlet UILabel *chatLabel;
@property(nonatomic,strong) ChatModel *chat;
@property(nonatomic,strong)NSString *head_url;
+(CGFloat)getCellHeightWithModel:(ChatModel *)cha;
@end
