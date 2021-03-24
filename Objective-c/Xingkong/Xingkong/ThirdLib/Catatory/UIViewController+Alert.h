//
//  UIViewController+Alert.h
//  CatPregnent2
//
//  Created by ji long on 2019/12/6.
//  Copyright © 2019 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController(Alert)
-(void)showAlert:(NSString *)messages;

////弹出框带回调
- (void)showAlert:(NSString *)messages handler:(void (^ __nullable)(UIAlertAction *action))handler;

/**
 显示提示消息,只有一个确定按钮与回调
 */
- (void)showTop:(NSString *)messages handler:(void (^ __nullable)(UIAlertAction *action))handler;

- (void)showHUD;

- (void)hideHUD;
@end

NS_ASSUME_NONNULL_END
