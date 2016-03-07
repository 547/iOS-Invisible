//
//  NSString+More.m
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "NSString+More.h"

@implementation NSString (More)
+(NSString *)trim:(NSString *)string
{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];

}
+(NSString *)changeDate:(NSDate *)date
{
    NSDateFormatter *forma=[[NSDateFormatter alloc]init];
    forma.dateFormat=@"yyyy.MM.dd HH:mm:ss";
    NSString *dateStr = [forma stringFromDate:date];
    return dateStr;
}
@end
