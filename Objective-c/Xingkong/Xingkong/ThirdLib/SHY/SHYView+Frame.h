//
//  SHYView+Frame.h
//  CatPregnent2
//
//  Created by MrSui on 2020/5/29.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , LeShadowPathType) {
    LeShadowPathTop    = 1,
    LeShadowPathBottom = 2,
    LeShadowPathLeft   = 3,
    LeShadowPathRight  = 4,
    LeShadowPathCommon = 5,
    LeShadowPathAround = 6,
    
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (nonatomic) CGFloat tz_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat tz_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat tz_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat tz_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat tz_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat tz_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat tz_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat tz_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint tz_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  tz_size;        ///< Shortcut for frame.size.



/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;


- (void)viewShadowPathWithColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowPathType:(LeShadowPathType)shadowPathType shadowPathWidth:(CGFloat)shadowPathWidth;
@end

NS_ASSUME_NONNULL_END
