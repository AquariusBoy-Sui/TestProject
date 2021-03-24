//
//  UITextView+configKeyboard.h
//  CatPregnent2
//
//  Created by ji long on 2020/8/19.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (configKeyboard)

-(void)configKeyboard:(nullable id)target action:(SEL)action;

//设置文字提示
-(void)setTextTip;
@end

NS_ASSUME_NONNULL_END
