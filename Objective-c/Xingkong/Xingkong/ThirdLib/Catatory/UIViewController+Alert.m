//
//  UIViewController+Alert.m
//  CatPregnent2
//
//  Created by ji long on 2019/12/6.
//  Copyright © 2019 Binky Lee. All rights reserved.
//

#import "UIViewController+Alert.h"
#import "MBProgressHUD.h"

@implementation UIViewController(Alert)

- (void)showAlert:(NSString *)messages {
    NSString *title = NSLocalizedString(@"提示", nil);
    NSString *message = NSLocalizedString(messages, nil);
    NSString *ButtonTitle = NSLocalizedString(@"确认", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:ButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了确定");
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showTop:(NSString *)messages handler:(void (^ __nullable)(UIAlertAction *action))handler{
    NSString *title = NSLocalizedString(@"提示", nil);
    NSString *message = NSLocalizedString(messages, nil);
    NSString *okButtonTitle = NSLocalizedString(@"确认", nil);
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault
                                                          handler:handler];
 
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)showAlert:(NSString *)messages  handler:(void (^ __nullable)(UIAlertAction *action))handler{

    NSString *title = NSLocalizedString(@"提示", nil);
    NSString *message = NSLocalizedString(messages, nil);
    NSString *okButtonTitle = NSLocalizedString(@"确认", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault
                                                          handler:handler];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleDefault
                                                          handler:handler];

    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];

}



- (void)showHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    });
}

- (void)hideHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    });
}

@end
