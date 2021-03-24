//
//  CachesImageView.m
//  CachesImageView
//
//  Created by jilong on 2020/4/4.
//  Copyright © 2020 jilong. All rights reserved.
//

#import "CachesImageView.h"
#import "UIImage+Base64.h"

@implementation CachesImageView

/**
  是否URL图片地址
 */
- (BOOL)isUrlAddress:(NSString*)url
{
    NSString *ext=[url pathExtension];
    if([ext isEqualToString:@"png"] || [ext isEqualToString:@"jpg"] || [ext isEqualToString:@"jpeg"])
    {
        return true;
    }
    return false;
}

/**
 是否为本地图片资源,资源是否主,字符串小于32
 */
-(BOOL)isLocalImageRes:(NSString*)imgStr{
    UIImage *img = [UIImage imageNamed:imgStr];
    if (img)
    {
        return true;
    }else{
        return false;
    }
}

- (UIActivityIndicatorView *)active
{
    if (!_active)
    {
        self.active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.active.color=[UIColor whiteColor];
        
        [self addSubview:self.active];
        [_active mas_makeConstraints:^(MASConstraintMaker *make) {
               make.centerX.centerY.equalTo(self);
        }];
    }
    return _active;
}

/**
 显示URL地址,先根据文件名获取沙盒中,如果没有,显示缓冲图像,下载URL地址
 */
-(void)showURLImage:(NSString*)string{
    
  
    //判断图片是否为本地的图片资源
    if([self isLocalImageRes:string])
    {
        
        self.image=[UIImage imageNamed:string];
        return;
    }
    
    //如果是base64编码,直接转码显示,需要最后判断
    if(![self isUrlAddress:string])
    {
        //如果是base64编码,直接转换
        self.image=[UIImage decodeBase64ToImage:string];
        return;
    }
    
    //判断文件是否在沙盒中
    //获取Library/Caches 文件夹
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //获取文件名(也就是取得路径的最后一个路径)
    NSString *fileName = [string lastPathComponent];
    //计算出全路径
    NSString *filePath = [cachesPath stringByAppendingPathComponent:fileName];
//    //取出图片
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        self.image=[UIImage imageWithData:data];
        [self.active stopAnimating];
        return;
    }
    
    //沙盒中不存在,需要下载,设置默认图片
    self.image=[UIImage imageNamed:@"img_photo_loading"];
    [self.active startAnimating];
 
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
        UIImage *image1 = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image=image1;
            [self.active stopAnimating];
            
        });
        // 将图片文件数据写入沙盒中
        [data writeToFile:filePath atomically:YES];
    });
}

/**
 获取UIImage,本地缓冲中
 */
+(UIImage*)loadImgUrl:(NSString*)imgStr{
    //判断图片是否为本地的图片资源
    UIImage *img = [UIImage imageNamed:imgStr];
    if(img)
    {
        return img;
    }
    
    //如果是base64编码,直接转码显示,需要最后判断
    
    NSString *ext=[imgStr pathExtension];
    if(!([ext isEqualToString:@"png"] || [ext isEqualToString:@"jpg"] || [ext isEqualToString:@"jpeg"]))
    {
        UIImage *image=[UIImage decodeBase64ToImage:imgStr];
        return image;
    }
    
    
    //判断文件是否在沙盒中
    //获取Library/Caches 文件夹
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //获取文件名(也就是取得路径的最后一个路径)
    NSString *fileName = [imgStr lastPathComponent];
    //计算出全路径
    NSString *filePath = [cachesPath stringByAppendingPathComponent:fileName];
    //    //取出图片
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        UIImage *image=[UIImage imageWithData:data];
        return image;
    }
    
    //沙盒中不存在,需要下载,设置默认图片
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgStr]];
    UIImage *image1 = [UIImage imageWithData:data];
    return image1;
}

@end
