//
//  PhotoBrowseModel.h
//  BGH-family
//
//  Created by Sunny on 17/2/24.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoBrowseModel : NSObject

/** 照片url */
@property(nonatomic, copy) UIImage *image;
@property(nonatomic, copy) NSString *imageUrl;
+ (instancetype)photoBrowseModelWith:(UIImage *)image;
+ (instancetype)photoUrlModelWith:(NSString *)imageUrl;
@end
