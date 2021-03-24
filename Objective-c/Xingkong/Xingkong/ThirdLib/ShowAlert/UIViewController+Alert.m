//
//  UIViewController+Alert.m
//  CatPregnent2
//
//  Created by ji long on 2019/12/6.
//  Copyright © 2019 Binky Lee. All rights reserved.
//

#import "UIViewController+Alert.h"

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
@end
