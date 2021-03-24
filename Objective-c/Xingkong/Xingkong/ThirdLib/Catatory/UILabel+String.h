//
//  UILabel+String.h
//  CatPregnent2
//  行间距设置
//  Created by ji long on 2020/8/18.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (String)
/**
 设置文本,并指定行间距

 @param text 文本内容
 @param lineSpacing 行间距
 */
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;
@end
NS_ASSUME_NONNULL_END
