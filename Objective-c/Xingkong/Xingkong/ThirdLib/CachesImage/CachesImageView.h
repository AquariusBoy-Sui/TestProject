//
//  CachesImageView.h
//  CachesImageView
//  显示缓存中的图片 UIImageView 展示URL
//  Created by jilong on 2020/4/4.
//  Copyright © 2020 jilong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface CachesImageView : UIImageView
@property (strong, nonatomic) UIActivityIndicatorView *active;
-(void)showURLImage:(NSString*)imageUrl;    //显示URL地址,先根据文件名获取沙盒中,如果没有,显示缓冲图像,下载URL地址
-(BOOL)isLocalImageRes:(NSString*)imgStr;

+(UIImage*)loadImgUrl:(NSString*)imgStr;    //获取UIImage,本地缓冲中
@end

NS_ASSUME_NONNULL_END
