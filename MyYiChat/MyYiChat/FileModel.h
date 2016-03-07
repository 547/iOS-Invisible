//
//  FileModel.h
//  MyYiChat
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject
@property(nonatomic,assign)BOOL isPerson;//是否是个人文件
@property(nonatomic,strong)NSString *Id;
@property(nonatomic,assign)int type;
@property(nonatomic,strong)NSString *mimetype;
@property(nonatomic,strong)NSString *image_url;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)BOOL isDownload;
@property(nonatomic,strong)NSString *fileDescription;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *tname;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,assign)int dtimes;
@property(nonatomic,assign)long long length;

+(id)createFileWithName:(NSString *)aName isPerson:(BOOL)aIsPerson Id:(NSString *)aId type:(int)aType mimetype:(NSString *)aMimetype image_url:(NSString *)aImage_url url:(NSString *)aUrl fileDescription:(NSString *)aFileDescription author:(NSString *)aAuthor tname:(NSString *)aTname time:(NSString *)aTime dtimes:(int)aDtimes length:(long long)aLength;
@end
