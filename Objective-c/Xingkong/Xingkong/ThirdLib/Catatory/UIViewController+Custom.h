//
//  UIViewController+Custom.h
//  FireFly-Merchant
//
//  Created by Binky Lee on 2017/2/18.
//  Copyright © 2017年 Binky Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Custom)

//黑色导行白字无下边线
- (void)blackColorNavigationBarWhiteFont;

- (void)setNavigationItemTitle:(NSString*)title imageName:(NSString*)imageName;

//设置标题图标及名称
- (void)setNavigationItemTitle:(NSString*)title image:(UIImage*)img;

    
//设置标题背景颜色
- (void)setNavigationBackground:(UIColor*)backColor;
@end
