//
//  UIImage+Caches.h
//  CachesImageView
//   图像缓存扩展类
//  Created by jilong on 2020/4/6.
//  Copyright © 2020 jilong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CachesImage)
@property (strong, nonatomic) NSString * imageName;   //图片名称

-(void)saveCachesImage:(NSString*)imageName;
@end

NS_ASSUME_NONNULL_END
