//
//  FileCollectionViewController.h
//  MyYiChat
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileCollectionViewController : UIViewController
@property(nonatomic,strong)NSMutableArray *fileArray;
-(id)initWithArray:(NSMutableArray *)array;
-(id)init;
@end
