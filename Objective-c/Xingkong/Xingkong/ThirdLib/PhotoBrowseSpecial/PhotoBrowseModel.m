//
//  PhotoBrowseModel.m
//  BGH-family
//
//  Created by Sunny on 17/2/24.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import "PhotoBrowseModel.h"

@implementation PhotoBrowseModel

+ (instancetype)photoBrowseModelWith:(UIImage *)image
{
    PhotoBrowseModel *model = [[self alloc] init];
    
    model.image = image ;
    
    return model;
}
+ (instancetype)photoUrlModelWith:(NSString *)imageUrl{
    PhotoBrowseModel *model = [[self alloc] init];
    model.imageUrl = imageUrl ;
    return model;
}
@end
