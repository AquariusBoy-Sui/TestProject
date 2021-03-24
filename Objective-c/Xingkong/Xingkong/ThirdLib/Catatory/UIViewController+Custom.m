//
//  UIViewController+Custom.m
//  FireFly-Merchant
//
//  Created by Binky Lee on 2017/2/18.
//  Copyright © 2017年 Binky Lee. All rights reserved.
//

#import "UIViewController+Custom.h"
#import <objc/runtime.h>
#import "Config.h"
#import "UIColor+system.h"

@implementation UIViewController (Custom)

//黑色导行白字无下边线
- (void)blackColorNavigationBarWhiteFont{
    [self.navigationController.navigationBar setBarTintColor:[UIColor getSystemBackgroundColor]];
    [self.navigationController.navigationBar setTintColor:getColor(@"2783b8")];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0],NSForegroundColorAttributeName: [UIColor getlabelColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
    if(self.navigationController.navigationBar.subviews.count>0)
    {
        self.navigationController.navigationBar.subviews[0].alpha = 1;
    }
    [self.navigationController.navigationBar setClipsToBounds:YES];
    self.navigationController.view.backgroundColor = [UIColor getSystemBackgroundColor];
}

- (void)setNavigationItemTitle:(NSString*)title imageName:(NSString*)imageName {
    UIView *view = [[UIView alloc] init];
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:imageName]];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.textColor = [UIColor getlabelColor];
    [label setText:title];
    [view addSubview:label];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@30);
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(view.mas_left);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(imageView.mas_right).offset(5);
        make.right.equalTo(view.mas_right);
    }];

    self.navigationItem.titleView = view;
}

- (void)setNavigationItemTitle:(NSString*)title image:(UIImage*)img {
    UIView *view = [[UIView alloc] init];
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:img];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.textColor = [UIColor getlabelColor];
    [label setText:title];
    [view addSubview:label];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@30);
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(view.mas_left);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(imageView.mas_right).offset(5);
        make.right.equalTo(view.mas_right);
    }];

    self.navigationItem.titleView = view;
}



- (void)setNavigationBackground:(UIColor*)backColor
{
   // self.navigationController.view.backgroundColor = backColor;
    [self.navigationController.navigationBar setBarTintColor:backColor];

}

    
@end
