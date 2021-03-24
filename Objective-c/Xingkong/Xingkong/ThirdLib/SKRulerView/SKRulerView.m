//
//  SKRulerView.m
//  0002
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SKRulerView.h"
#import "SKRulerViewConfiguration.h"

@implementation SKRulerView



@end


///部分低于范围刻度内显示的cell
@implementation LowerThanScaleViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.numberlabel = [[UILabel alloc] initWithFrame:CGRectMake(-frame.size.width/2.0, SKShareConfiguration.longScale_h+SKShareConfiguration.rulerTitle_Padding, frame.size.width, 30)];
        self.numberlabel.font = [UIFont systemFontOfSize:SKShareConfiguration.rulerFont];
        self.numberlabel.textColor = SKShareConfiguration.rulerTitle_Color;
        self.numberlabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.numberlabel];
        //获取范围
        NSString * thresholdString = [NSString stringWithFormat:@"%f",(SKShareConfiguration.minThresholdValue - SKShareConfiguration.minValue)/SKShareConfiguration.step/10];
        NSArray * array = [thresholdString componentsSeparatedByString:@"."];
        if (array.count == 1) {
            self.number = 0;
        }else{
            self.number = [array[1] integerValue]/100000;
            if (self.number == 0) {
                self.number = 10;
            }
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    for (int i = 0; i<=10; i++) {
        
        UIBezierPath * bezierPath = [[UIBezierPath alloc] init];
        [bezierPath moveToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, 0)];
        
        
        if (i == 0) {
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.longScale_h)];
            [SKShareConfiguration.beyondCScale_c set];//颜色填充
            bezierPath.lineWidth = SKShareConfiguration.longScale_w;
            
        }else if (i == 5){
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.semiScale_h)];
            bezierPath.lineWidth = SKShareConfiguration.semiScale_w;
            if (i < self.number) {
                [SKShareConfiguration.beyondCScale_c set];//颜色填充
            }else{
                [SKShareConfiguration.semiScale_c set];//颜色填充
            }
            
            
        }else if(i == 10){
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.longScale_h)];
            [SKShareConfiguration.longScale_c set];//颜色填充
            bezierPath.lineWidth = SKShareConfiguration.longScale_w;
            
        }else{
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.shortScale_h)];
            bezierPath.lineWidth = SKShareConfiguration.shortScale_w;
            
            if (i <= self.number) {
                [SKShareConfiguration.beyondCScale_c set];//颜色填充
            }else{
                [SKShareConfiguration.shortScale_c set];//颜色填充
            }
        }
        bezierPath.lineCapStyle = kCGLineCapRound; //线条拐角
        bezierPath.lineJoinStyle = kCGLineJoinRound; //终点处理
        [bezierPath stroke];
    }
}

@end



///正常刻度内显示的cell
@implementation NormalScaleViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.numberlabel = [[UILabel alloc] initWithFrame:CGRectMake(-frame.size.width/2.0, SKShareConfiguration.longScale_h+SKShareConfiguration.rulerTitle_Padding, frame.size.width, 30)];
        self.numberlabel.font = [UIFont systemFontOfSize:SKShareConfiguration.rulerFont];
        self.numberlabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.numberlabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    for (int i = 0; i<=10; i++) {
        
        UIBezierPath * bezierPath = [[UIBezierPath alloc] init];
        [bezierPath moveToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, 0)];
        
        if (i == 0||i == 10) {
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.longScale_h)];
            [SKShareConfiguration.longScale_c set];//颜色填充
            bezierPath.lineWidth = SKShareConfiguration.longScale_w;
        }else if (i == 5){
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.semiScale_h)];
            [SKShareConfiguration.semiScale_c set];//颜色填充
            bezierPath.lineWidth = SKShareConfiguration.semiScale_w;
        }else{
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.shortScale_h)];
            [SKShareConfiguration.shortScale_c set];//颜色填充
            bezierPath.lineWidth = SKShareConfiguration.shortScale_w;
        }
        bezierPath.lineCapStyle = kCGLineCapRound; //线条拐角
        bezierPath.lineJoinStyle = kCGLineJoinRound; //终点处理
        [bezierPath stroke];
    }
}

@end
///部分超出范围显示的cell
@implementation PartBeyondScaleViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.numberlabel = [[UILabel alloc] initWithFrame:CGRectMake(-frame.size.width/2.0, SKShareConfiguration.longScale_h+SKShareConfiguration.rulerTitle_Padding, frame.size.width, 30)];
        self.numberlabel.font = [UIFont systemFontOfSize:SKShareConfiguration.rulerFont];
        self.numberlabel.textColor = SKShareConfiguration.rulerTitle_Color;
        self.numberlabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.numberlabel];
        //获取范围
        NSString * thresholdString = [NSString stringWithFormat:@"%f",(SKShareConfiguration.maxThresholdValue - SKShareConfiguration.minValue)/SKShareConfiguration.step/10];
        NSArray * array = [thresholdString componentsSeparatedByString:@"."];
        if (array.count == 1) {
            self.number = 0;
        }else{
            self.number = [array[1] integerValue]/100000;
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    for (int i = 0; i<=10; i++) {
        
        UIBezierPath * bezierPath = [[UIBezierPath alloc] init];
        [bezierPath moveToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, 0)];
        
        
        if (i == 0) {
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.longScale_h)];
            [SKShareConfiguration.longScale_c set];//颜色填充
            bezierPath.lineWidth = SKShareConfiguration.longScale_w;
            
        }else if (i == 5){
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.semiScale_h)];
            bezierPath.lineWidth = SKShareConfiguration.semiScale_w;
            if (i <= self.number) {
                [SKShareConfiguration.semiScale_c set];//颜色填充
            }else{
                [SKShareConfiguration.beyondCScale_c set];//颜色填充
            }
            
            
        }else if(i == 10){
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.longScale_h)];
            [SKShareConfiguration.beyondCScale_c set];//颜色填充
            bezierPath.lineWidth = SKShareConfiguration.longScale_w;
            
        }else{
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.shortScale_h)];
            bezierPath.lineWidth = SKShareConfiguration.shortScale_w;

            if (i <= self.number) {
                [SKShareConfiguration.shortScale_c set];//颜色填充
            }else{
                [SKShareConfiguration.beyondCScale_c set];//颜色填充
            }
        }
        bezierPath.lineCapStyle = kCGLineCapRound; //线条拐角
        bezierPath.lineJoinStyle = kCGLineJoinRound; //终点处理
        [bezierPath stroke];
    }
}

@end
///超出刻度范围显示不同的cell
@implementation BeyondScaleViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.numberlabel = [[UILabel alloc] initWithFrame:CGRectMake(-frame.size.width/2.0, SKShareConfiguration.longScale_h+SKShareConfiguration.rulerTitle_Padding, frame.size.width, 30)];
        self.numberlabel.font = [UIFont systemFontOfSize:SKShareConfiguration.rulerFont];
        self.numberlabel.textAlignment = NSTextAlignmentCenter;
        self.numberlabel.textColor = SKShareConfiguration.beyondCScale_c;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.numberlabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    for (int i = 0; i<=10; i++) {
        
        UIBezierPath * bezierPath = [[UIBezierPath alloc] init];
        [bezierPath moveToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, 0)];
        
        if (i == 0||i == 10) {
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.longScale_h)];
            [SKShareConfiguration.beyondCScale_c set];//颜色填充
            bezierPath.lineWidth = SKShareConfiguration.longScale_w;
        }else if (i == 5){
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.semiScale_h)];
            [SKShareConfiguration.beyondCScale_c set];//颜色填充
            bezierPath.lineWidth = SKShareConfiguration.semiScale_w;
            
        }else{
            [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.rulerGap*i, SKShareConfiguration.shortScale_h)];
            [SKShareConfiguration.beyondCScale_c set];//颜色填充
            bezierPath.lineWidth = SKShareConfiguration.shortScale_w;
        }
        bezierPath.lineCapStyle = kCGLineCapRound; //线条拐角
        bezierPath.lineJoinStyle = kCGLineJoinRound; //终点处理
        [bezierPath stroke];
    }
}



@end

///头部cell
@implementation HeaderCell

- (void)drawRect:(CGRect)rect{
    

    UIBezierPath * bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(self.frame.size.width, 0)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, SKShareConfiguration.longScale_h)];
    if (SKShareConfiguration.minThresholdValue<=0) {
       [SKShareConfiguration.longScale_c set];//颜色填充
    }else{
        [SKShareConfiguration.beyondCScale_c set];//颜色填充
    }
    bezierPath.lineWidth = SKShareConfiguration.longScale_w;
    bezierPath.lineCapStyle = kCGLineCapRound; //线条拐角
    bezierPath.lineJoinStyle = kCGLineJoinRound; //终点处理
    [bezierPath stroke];
    
}

@end

///尾部cell
@implementation FooterCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {

        self.numberlabel = [[UILabel alloc] initWithFrame:CGRectMake(-SKShareConfiguration.rulerGap*10/2.0, SKShareConfiguration.longScale_h+SKShareConfiguration.rulerTitle_Padding, SKShareConfiguration.rulerGap*10, 30)];
        if (SKShareConfiguration.maxThresholdValue < SKShareConfiguration.maxValue) {
            self.numberlabel.textColor = SKShareConfiguration.beyondCScale_c;
        }else{
            self.numberlabel.textColor = SKShareConfiguration.rulerTitle_Color;
        }
        self.numberlabel.font = [UIFont systemFontOfSize:SKShareConfiguration.rulerFont];
        self.numberlabel.textAlignment = NSTextAlignmentCenter;
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.numberlabel];
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    
    UIBezierPath * bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(0, SKShareConfiguration.longScale_h)];

    
    if (SKShareConfiguration.maxThresholdValue < SKShareConfiguration.maxValue) {
        [SKShareConfiguration.beyondCScale_c set];//颜色填充
    }else{
        [SKShareConfiguration.longScale_c set];//颜色填充

    }
    
    bezierPath.lineWidth = SKShareConfiguration.longScale_w;
    bezierPath.lineCapStyle = kCGLineCapRound; //线条拐角
    bezierPath.lineJoinStyle = kCGLineJoinRound; //终点处理
    [bezierPath stroke];
    
}
@end




@implementation SKTriangleView

#pragma mark ===============绘制指针===============
- (void)drawRect:(CGRect)rect{
    [SKShareConfiguration.triangle_Color set];//颜色填充
    
    UIBezierPath * bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.triangle_w/2.0, SKShareConfiguration.triangle_h)];
    [bezierPath addLineToPoint:CGPointMake(SKShareConfiguration.triangle_w, 0)];
    
    [bezierPath closePath];
    bezierPath.lineWidth = SKShareConfiguration.longScale_w;
    bezierPath.lineCapStyle = kCGLineCapRound; //线条拐角
    bezierPath.lineJoinStyle = kCGLineJoinMiter; //终点处理
    [bezierPath fill];
    
}


@end
