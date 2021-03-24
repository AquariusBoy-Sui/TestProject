//
//  ImageManager.h
//  CachesImageView
//  负责图片的缓存管理
//  Created by jilong on 2020/4/5.
//  Copyright © 2020 jilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageManager : NSObject
+(ImageManager*)shareImageManager;

-(NSString*)saveImage:(UIImage*)imgs;                   //保存图片,必须有accessibilityIdentifier 设置name;返回URL路径
-(void)removeImage:(NSString*)deleImage;                //删除猫孕照片
-(void)postServerImage:(UIImage*)imageName;             //提交图片到服务器
-(void)resume;                                          //启动恢复提交数据,当时为提交完成,下次启动再提交


//提交服务器图片指定名称,必须有accessibilityIdentifier 设置name;返回URL路径
-(void)updateImage:(UIImage*)imgs withBlock:(FunCall(int state,NSString* msg,NSString* url))block;
@end

NS_ASSUME_NONNULL_END
