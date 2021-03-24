//
//  UIImage+Caches.m
//  CachesImageView
//
//  Created by jilong on 2020/4/6.
//  Copyright © 2020 jilong. All rights reserved.
//

#import "UIImage+Caches.h"

@implementation UIImage (CachesImage)
@dynamic imageName;

-(void)saveCachesImage:(NSString*)imageName{
    //1、保存到本地缓存沙盒
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //计算出全路径
    NSString *filePath = [cachesPath stringByAppendingPathComponent:imageName];
    NSData *data;
    //判断图片是不是png格式的文件
//    if(UIImagePNGRepresentation(self))
//        data = UIImagePNGRepresentation(self);
//    //判断图片是不是jpeg格式的文件
//    else
    //只保存jpeg格式图片
    data = UIImageJPEGRepresentation(self,1.0);
    [data writeToFile:filePath atomically:YES];
    
}

@end;
