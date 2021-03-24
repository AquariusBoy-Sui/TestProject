//
//  UIColor+system.m
//  CatPregnent2
//
//  Created by ji long on 2019/11/26.
//  Copyright © 2019 Binky Lee. All rights reserved.
//

#import "UIColor+system.h"

@implementation UIColor(system)


+ (UIColor*)getSystemBackgroundColor
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemBackgroundColor];
    }
    
    return [UIColor blackColor];
    
}

+ (UIColor*)getSecondarySystemBackgroundColor
{
    if (@available(iOS 13.0, *)) {
        return [UIColor secondarySystemBackgroundColor];
    }
    
    return [UIColor grayColor];
    
}

+ (UIColor*)getTertiarySystemBackgroundColor
{
    if (@available(iOS 13.0, *)) {
        return [UIColor tertiarySystemBackgroundColor];
    }
    
    return [UIColor blackColor];
    
}


+ (UIColor*)getSystemBackgroundColorNormalWhite
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemBackgroundColor];
    }
    
    return [UIColor whiteColor];
    
}


+ (UIColor*)getlabelColor
{
    if (@available(iOS 13.0, *)) {
        return [UIColor labelColor];
    }
    
    return [UIColor whiteColor];
}

/**
 获取第二系统颜色
 */
+(UIColor*) getSecondarySystemlabelColor{
    if (@available(iOS 13.0, *)) {
        return [UIColor secondaryLabelColor];
    }
    
    return [UIColor grayColor];
}


+ (UIColor*)getNormalLabelColor
{
    if (@available(iOS 13.0, *)) {
        return [UIColor labelColor];
    }
    
    return getColor(@"515151");
}

/**
 获取视图标题颜色
 */
+(UIColor*) getViewControllerColor
{
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {  //深色模式
            //NSLog(@"深色模式");
            return getColor(@"2c2c2e");
        } else if (mode == UIUserInterfaceStyleLight) { //浅色模式
            return getColor(@"ffffff");
        } else {                                        //浅色模式
            return getColor(@"2c2c2e");
        }
    }
    return getColor(@"2c2c2e");
}


+(UIColor*) getTableViewHeaderFooterViewColor
{
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {  //深色模式
            return getColor(@"A9A9A9");
        }
        if (mode == UIUserInterfaceStyleLight) { //浅色模式
            return getColor(@"D3D3D3");
        }
        if(mode == UIUserInterfaceStyleUnspecified) { //浅色模式
            return getColor(@"D3D3D3");
        }
    }
    return getColor(@"D3D3D3");
}
+(UIColor*) getNavigationItemTitleColor
{
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {  //深色模式
            return getColor(@"F2F2F2");
        }
        if (mode == UIUserInterfaceStyleLight) { //浅色模式
            return getColor(@"A9A9A9");
        }
        if(mode == UIUserInterfaceStyleUnspecified) { //浅色模式
            return getColor(@"D3D3D3");
        }
    }
     return [UIColor whiteColor];
}
+(UIColor*) getGrayLabelColor{
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {  //深色模式
            return getColor(@"CCCCCC");
        }
        if (mode == UIUserInterfaceStyleLight) { //浅色模式
            return getColor(@"656565");
        }
        if(mode == UIUserInterfaceStyleUnspecified) { //浅色模式
            return getColor(@"656565");
        }
    }
     return getColor(@"656565");
}
@end
