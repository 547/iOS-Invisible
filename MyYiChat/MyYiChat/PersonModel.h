//
//  PersonModel.h
//  MyYiChat
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *headerUrl;
+(id)createPersonWithName:(NSString *)aName nickName:(NSString *)aNickName email:(NSString *)aEmail headerUrl:(NSString *)aHeaderUrl;
@end
