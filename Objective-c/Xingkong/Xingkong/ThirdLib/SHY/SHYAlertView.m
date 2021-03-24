//
//  SHYAlertView.m
//  CatPregnent2
//
//  Created by MrSui on 2020/5/29.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "SHYAlertView.h"

@implementation UIViewController(SHYAlertView)

-(void)showUploadHUD:(NSString *)text{
     dispatch_async(dispatch_get_main_queue(), ^{
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
            hud.removeFromSuperViewOnHide = YES;
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.label.text =text;
            [[UIApplication sharedApplication].keyWindow addSubview:hud];
            [hud showAnimated:YES];
    });
}

-(void)showAlertViewWithText:(NSString *)text delayHid:(NSTimeInterval)delay {
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    progressHUD.animationType = MBProgressHUDAnimationFade;
    progressHUD.mode = MBProgressHUDModeText;
    progressHUD.label.text = text;
    progressHUD.label.numberOfLines = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:progressHUD];
    [progressHUD showAnimated:YES];
    [progressHUD hideAnimated:YES afterDelay:delay];
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

-(void)showUploadHUD{
     dispatch_async(dispatch_get_main_queue(), ^{
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
            hud.removeFromSuperViewOnHide = YES;
            hud.mode = MBProgressHUDModeDeterminate;
            hud.label.text = @"正在上传文件,上传进度:0%";
            [[UIApplication sharedApplication].keyWindow addSubview:hud];
            [hud showAnimated:YES];
    });
}

-(void)setUploadHUDProgress:(float)progress{
     dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
         hud.progress=progress;
         if (progress == 1 ) {
             hud.label.text = @"上传完成";
         }else{
             hud.label.text = [NSString  stringWithFormat: @"正在上传文件,上传进度:%0.f%%",progress*100];
         }
         
    });
}
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
-(BOOL)showNetworkStatusAndLoginStatus{
    BOOL isNext=true;
    
     PersonBLL *pb=[PersonBLL instance ];

     BOOL networkStatus=[[CoreDataBLL instance] networkAccess];
     if(!networkStatus)
     {
         [self showTop:@"网络连接失败,请检查网络状态!" handler:nil];
         return false;
     }
     if (![pb isSign]) {
         [self showTop:@"请登录后尝试" handler:nil];
        return false;
     }
    return isNext;
}


@end
