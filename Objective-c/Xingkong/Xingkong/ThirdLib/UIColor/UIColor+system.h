//
//  UIColor+system.h
//  CatPregnent2
//
//  Created by ji long on 2019/11/26.
//  Copyright © 2019 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor(system)
//获取系统颜色
+(UIColor*) getSystemBackgroundColor;
+ (UIColor*)getSystemBackgroundColorNormalWhite;
+ (UIColor*)getSecondarySystemBackgroundColor;   //系统第二种颜色
+ (UIColor*)getTertiarySystemBackgroundColor;   //系统第三种颜色


+(UIColor*) getlabelColor;
+(UIColor*) getSecondarySystemlabelColor;   //获取第二系统颜色
+(UIColor*) getGrayLabelColor; 
+(UIColor*) getViewControllerColor;     //获取视图标题颜色
+(UIColor*) getNormalLabelColor;
+(UIColor*) getTableViewHeaderFooterViewColor;//获取TableView  Header Footer 灰色
+(UIColor*) getNavigationItemTitleColor;

@end

NS_ASSUME_NONNULL_END
