//
//  UIImage+Base64.m
//  CatPregnent2
//
//  Created by ji long on 2019/11/22.
//  Copyright © 2019 Binky Lee. All rights reserved.
//

#import "UIImage+Base64.h"

@implementation  UIImage (CoreDataProperties)

+(NSString*)encodeToBase64String:(UIImage*)image
{
    //NSData *imageData=UIImagePNGRepresentation(image);
//    if(!imageData)
//    {
//        imageData=UIImageJPEGRepresentation(image,1.0);
//    }
    //保存jpeg格式,避免图片太大
    NSData *imageData=UIImageJPEGRepresentation(image,1.0);
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+(UIImage*)decodeBase64ToImage:(NSString*)strEncodeData {
    if(!strEncodeData) return nil;
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}


+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize compressionQuality:(CGFloat)q
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIImage imageWithData:UIImageJPEGRepresentation(newImage, q)];
    
}

/**
 显示图片大小
 */
+(void)sizeForImage:(UIImage*)aImage
{
    NSData *data = UIImagePNGRepresentation(aImage);
    if (!data) {
        data = UIImageJPEGRepresentation(aImage, 1.0);//需要改成0.5才接近原图片大小，原因请看下文
    }
    double dataLength = [data length] * 1.0;
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (dataLength > 1024) {
        dataLength /= 1024.0;
        index ++;
    }
    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
}


@end
