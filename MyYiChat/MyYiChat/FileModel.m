//
//  FileModel.m
//  MyYiChat
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "FileModel.h"

@implementation FileModel
+(id)createFileWithName:(NSString *)aName isPerson:(BOOL)aIsPerson Id:(NSString *)aId type:(int)aType mimetype:(NSString *)aMimetype image_url:(NSString *)aImage_url url:(NSString *)aUrl fileDescription:(NSString *)aFileDescription author:(NSString *)aAuthor tname:(NSString *)aTname time:(NSString *)aTime dtimes:(int)aDtimes length:(long long)aLength
{
    FileModel *file=[[FileModel alloc]init];
    file.name=aName;
    file.isPerson=aIsPerson;
    file.Id=aId;
    file.type=aType;
    file.mimetype=aMimetype;
    file.image_url=aImage_url;
    file.url=aUrl;
    file.fileDescription=aFileDescription;
    file.author=aAuthor;
    file.tname=aTname;
    file.time=aTime;
    file.dtimes=aDtimes;
    file.length=aLength;
    
    return file;
}
@end
