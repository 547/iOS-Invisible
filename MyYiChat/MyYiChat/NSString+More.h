//
//  NSString+More.h
//  MyYiChat
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (More)
+(NSString *)trim:(NSString *)string;
+(NSString *)changeDate:(NSDate *)date;
+(NSString *)getPathOfDoucoment:(NSString *)name;
@end
