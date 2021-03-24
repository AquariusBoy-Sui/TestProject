//
//  PhotoBrowseController.h
//  BGH-family
//
//  Created by Sunny on 17/2/24.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowseController : UIViewController
/** 初始化方法 */
- (instancetype)initWithAllPhotosArray:(NSMutableArray *)photosArr currentIndex:(NSInteger)currentIndex way:(NSInteger )way;
- (instancetype)initWithAllPhotosUrlArray:(NSArray *)photosurl currentIndex:(NSInteger)currentIndex way:(NSInteger )way;
 /*
  
  参数1：photosArr --- 保存uiimage的数组  
  参数2：currentIndex --- 当前为第几张图片 从0开始
  参数3：way --- 进入当前Controller的方式（传1为通过导航栏push的的方式，传其他为present的方式）
  
  */
@end
