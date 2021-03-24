//
//  UIImage+Base64.h
//  CatPregnent2
//
//  Created by ji long on 2019/11/22.
//  Copyright © 2019 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CoreDataProperties)

+(NSString*)encodeToBase64String:(UIImage*)image;

+(UIImage*)decodeBase64ToImage:(NSString*)strEncodeData;

//压缩图片大小与质量
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize compressionQuality:(CGFloat)q;

//显示图片大小
+(void)sizeForImage:(UIImage*)aImage;

@end

NS_ASSUME_NONNULL_END
