//
//  PersonModel.m
//  MyYiChat
//
//  Created by mac on 16/3/3.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "PersonModel.h"
//static PersonModel *per;
@implementation PersonModel
//+(id)alloc
//{
//    @synchronized(self) {
//        if (per==nil) {
//            per=[super alloc];
//        }
//
//    }
//    return per;
//}
//-(id)init
//{
//    @synchronized(self) {
//        if (per==nil) {
//            per=[super init];
//        }
//
//    }
//    return per;
//}
+(id)createPersonWithName:(NSString *)aName nickName:(NSString *)aNickName email:(NSString *)aEmail headerUrl:(NSString *)aHeaderUrl
{
   
    
    PersonModel *per=[[PersonModel alloc]init];
    per.name=aName;
    per.nickName=aNickName;
    per.email=aEmail;
    per.headerUrl=aHeaderUrl;
    return per;

}
@end
