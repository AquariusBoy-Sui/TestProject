//
//  LRSChartView.m
//  LRSChartView
//
//  Created by lreson on 16/7/21.
//  Copyright © 2016年 lreson. All rights reserved.
//

#import "LRSChartView.h"
#import "UIImage+Common.h"
#import "UIButton+EnlargeTouchArea.h"
#import "UIView+Common.h"
#import "UIColor+Expanded.h"

#define btnW 12
#define titleWOfY 30
@interface LRSChartView ()<UIScrollViewDelegate>
{
    CGFloat currentPage;//当前页数
    CGFloat Xmargin;//X轴方向的偏移
    CGFloat Ymargin;//Y轴方向的偏移
    CGPoint lastPoint;//最后一个坐标点
    UIButton *firstBtn;
    UIButton *lastBtn;
}

@property (nonatomic,strong)UIScrollView *chartScrollView;
@property (nonatomic,strong)UIView *bgView1;//背景图
@property (nonatomic,strong)UIPageControl *pageControl;//分页
@property (nonatomic,strong)UIView *scrollBgView1;
@property (nonatomic,strong)NSMutableArray *leftPointArr;//左边的数据源
@property (nonatomic,strong)NSMutableArray *leftBtnArr;//左边按钮
@property (nonatomic, strong)NSMutableArray *detailLabelArr;
@property (nonatomic,strong)NSArray *leftScaleArr;
@property (nonatomic,strong)NSMutableArray *leftScaleViewArr;//左边的点击显示图
@property (nonatomic,strong)UIView *scaleBgView;
@property (nonatomic,strong)UILabel *lineLabel;
@property (nonatomic,strong)UILabel *scaleLabel;
@property (nonatomic,strong)UILabel *dateTimeLabel;


@end

@implementation LRSChartView

-(UILabel *)scaleLabel{
    if (!_scaleLabel) {
        _scaleLabel = [[UILabel alloc]init];
        _scaleLabel.textAlignment = 1;
        _scaleLabel.text = @"3.3681%";
        _scaleLabel.font = [UIFont systemFontOfSize:11];
        _scaleLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:159/255.0 blue:106/255.0 alpha:1];
        _scaleLabel.textColor = [UIColor whiteColor];
    }
    return _scaleLabel;
    
}

-(UILabel *)dateTimeLabel{
    if (!_dateTimeLabel) {
        _dateTimeLabel = [[UILabel alloc]init];
        _dateTimeLabel.textAlignment = 1;
        _dateTimeLabel.text = @"2016.04.16";
        _dateTimeLabel.font = [UIFont systemFontOfSize:11];
        _dateTimeLabel.backgroundColor = [UIColor whiteColor];
        _dateTimeLabel.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1];
    }
    return _dateTimeLabel;
    
    
    
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:159/255.0 blue:106/255.0 alpha:1];
    }
    return _lineLabel;
}


/**  背景 */
-(UIView *)scrollBgView1{
    if (!_scrollBgView1) {
        _scrollBgView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.chartScrollView.bounds.size.width, self.chartScrollView.bounds.size.height)];
        
    }
    return _scrollBgView1;
    
}


/**  背景网格 */
-(UIView *)bgView1{
    if (!_bgView1) {
        _bgView1 = [[UIView alloc]initWithFrame:CGRectMake(5, 0, self.scrollBgView1.bounds.size.width - 25, self.scrollBgView1.bounds.size.height-100)];
        _bgView1.layer.masksToBounds = YES;
        //        _bgView1.layer.cornerRadius = 5;
        _bgView1.layer.borderWidth = 1;
        _bgView1.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1].CGColor;
    }
    
    return _bgView1;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        currentPage = 0;
        self.leftPointArr = [NSMutableArray array];
        self.leftBtnArr = [NSMutableArray array];
        self.detailLabelArr = [NSMutableArray array];
        self.leftScaleArr = [NSArray array];
        self.leftScaleViewArr = [NSMutableArray array];
        [self addDetailViews];
    }
    
    return self;
    
    
}

//*******************数据源************************//

-(void)setDataArrOfX:(NSArray *)dataArrOfX{
    
    _dataArrOfX = dataArrOfX;
    [self addLines1With:self.bgView1];
    [self addDataPointWith:self.scrollBgView1 andArr:_leftDataArr];//添加点
    [self addLeftBezierPoint];//添加连线
    [self addLeftViews];
    [self addBottomViewsWith:self.scrollBgView1];
}

-(void)setDataArrOfY:(NSArray *)dataArrOfY{
    
    _dataArrOfY = dataArrOfY;
}


-(void)setLeftDataArr:(NSArray *)leftDataArr{
    
    _leftDataArr = leftDataArr;
    self.chartScrollView.scrollEnabled = NO;
    self.pageControl.numberOfPages = 1;
}




//*******************分割线************************//
-(void)addDetailViews{
    
    self.chartScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(titleWOfY, 0, self.bounds.size.width-titleWOfY, self.bounds.size.height)];
    self.chartScrollView.contentOffset = CGPointMake(0, 0);
    self.chartScrollView.backgroundColor = [UIColor clearColor];
    self.chartScrollView.delegate = self;
    self.chartScrollView.showsHorizontalScrollIndicator = NO;
    self.chartScrollView.pagingEnabled = YES;
    self.chartScrollView.contentSize = CGSizeMake(self.bounds.size.width*2, 0);
    
    [self addSubview:self.chartScrollView];
    [self addSubview:self.pageControl];
    [self.chartScrollView addSubview:self.scrollBgView1];
    [self.scrollBgView1 addSubview:self.bgView1];
    
    
    
    //    [self addLines1With:self.bgView1];
    //    [self addLines1With:self.bgView2];
    
    //    [self addSubview:self.titleOfX];
    //    [self addSubview:self.titleOfY];
    //添加左边数值
    //    [self addLeftViews];
    
    //添加底部月份
    //    [self addBottomViewsWith:self.scrollBgView1];
    //    [self addBottomViewsWith:self.scrollBgView2];
    
    
    
    
    //NSLog(@"%f",Xmargin);
    // NSLog(@"%f",Ymargin);
    
}



//添加左边的坐标线
-(void)addLeftBezierPoint{
    
    //取得起始点
    CGPoint p1 = [[self.leftPointArr objectAtIndex:0] CGPointValue];
    NSLog(@"%f %f",p1.x,p1.y);
    
    //直线的连线
    UIBezierPath *beizer = [UIBezierPath bezierPath];
    [beizer moveToPoint:p1];
    
    //遮罩层的形状
    UIBezierPath *bezier1 = [UIBezierPath bezierPath];
    bezier1.lineCapStyle = kCGLineCapRound;
    bezier1.lineJoinStyle = kCGLineJoinMiter;
    [bezier1 moveToPoint:p1];
    
    
    for (int i = 0;i<self.leftPointArr.count;i++ ) {
        if (i != 0) {
            
            CGPoint prePoint = [[self.leftPointArr objectAtIndex:i-1] CGPointValue];
            CGPoint nowPoint = [[self.leftPointArr objectAtIndex:i] CGPointValue];
            //            [beizer addLineToPoint:point];
            [beizer addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];
            
            
            //            [bezier1 addLineToPoint:nowPoint];
            [bezier1 addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];
            
            if (i == self.leftPointArr.count-1) {
                [beizer moveToPoint:nowPoint];//添加连线
                lastPoint = nowPoint;
            }
        }
    }
    
    CGFloat bgViewHeight = self.bgView1.bounds.size.height;
    
    //获取最后一个点的X值
    CGFloat lastPointX = lastPoint.x;
    
    //最后一个点对应的X轴的值
    
    CGPoint lastPointX1 = CGPointMake(lastPointX, bgViewHeight);
    
    [bezier1 addLineToPoint:lastPointX1];
    
    //回到原点
    
    [bezier1 addLineToPoint:CGPointMake(p1.x, bgViewHeight)];
    
    [bezier1 addLineToPoint:p1];
    
    //遮罩层
    CAShapeLayer *shadeLayer = [CAShapeLayer layer];
    shadeLayer.path = bezier1.CGPath;
    shadeLayer.fillColor = [UIColor greenColor].CGColor;
    
    
    //渐变图层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(5, 0, 0, self.scrollBgView1.bounds.size.height-60);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.cornerRadius = 5;
    gradientLayer.masksToBounds = YES;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"0xf38b10" andAlpha:0.2].CGColor,(__bridge id)[UIColor colorWithHexString:@"0xf38b10" andAlpha:0.0].CGColor];
    gradientLayer.locations = @[@(0.5f)];
    
    CALayer *baseLayer = [CALayer layer];
    [baseLayer addSublayer:gradientLayer];
    [baseLayer setMask:shadeLayer];
    
    [self.scrollBgView1.layer addSublayer:baseLayer];
    
    CABasicAnimation *anmi1 = [CABasicAnimation animation];
    anmi1.keyPath = @"bounds";
    anmi1.duration = 2.0f;
    anmi1.toValue = [NSValue valueWithCGRect:CGRectMake(5, 0, 2*lastPoint.x, self.scrollBgView1.bounds.size.height-60)];
    anmi1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi1.fillMode = kCAFillModeForwards;
    anmi1.autoreverses = NO;
    anmi1.removedOnCompletion = NO;
    
    [gradientLayer addAnimation:anmi1 forKey:@"bounds"];
    
    
    //*****************添加动画连线******************//
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = beizer.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor colorWithHexString:@"0xf38b10" andAlpha:1.0].CGColor;
    shapeLayer.lineWidth = 2;
    [self.scrollBgView1.layer addSublayer:shapeLayer];
    
    
    CABasicAnimation *anmi = [CABasicAnimation animation];
    anmi.keyPath = @"strokeEnd";
    anmi.fromValue = [NSNumber numberWithFloat:0];
    anmi.toValue = [NSNumber numberWithFloat:1.0f];
    anmi.duration =2.0f;
    anmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi.autoreverses = NO;
    
    [shapeLayer addAnimation:anmi forKey:@"stroke"];
    
    for (UIButton *btn in self.leftBtnArr) {
        [self.scrollBgView1 addSubview:btn];
    }
    
    
}


-(void)addDataPointWith:(UIView *)view andArr:(NSArray *)leftData{
    
    self.leftScaleArr = leftData;
    
    CGFloat height = self.bgView1.bounds.size.height;
    
    //初始点
    NSMutableArray *arr = [NSMutableArray arrayWithArray:leftData];
    [arr insertObject:arr[0] atIndex:0];
    
    //    CGFloat lineHeight = 0.5*height;//线的高度
    
    float tempMax = [arr[0] floatValue];
    for (int i = 1; i < arr.count; ++i) {
        if ([arr[i] floatValue] > tempMax) {
            tempMax = [arr[i] floatValue];
        }
    }
    //    NSLog(@"\n-------tempMax-------\n%f",tempMax);
    
    for (int i = 0; i<arr.count; i++) {
        
        float tempHeight = [arr[i] floatValue] * 0.8 / tempMax ;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((Xmargin)*i, height *(1 - tempHeight) - btnW/2 , btnW, btnW)];
        
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = btnW/2;
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        if (i == 0) {
            firstBtn = btn;
            btn.hidden = YES;
        }else if ( i == arr.count - 1){
            
            lastBtn = btn;
            btn.selected = YES;
        }
        [btn setBackgroundImage:[UIImage imageNamed:@"img_wdzc_zcfx_sye_ellipse"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"img_wdzc_zcfx_sye_ellipse_hollow"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(TopBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setEnlargeEdgeWithTop:15 right:15 bottom:15 left:15];
        
        [self.leftBtnArr addObject:btn];
        
        NSValue *point = [NSValue valueWithCGPoint:btn.center];
        [self.leftPointArr addObject:point];
        
        /** 创建Label */
        UILabel * detailLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.scrollBgView1 addSubview: detailLabel];
        detailLabel.textColor = [UIColor colorWithHexString:@"0xf38b10"];
//        detailLabel.backgroundColor=[UIColor redColor];
        detailLabel.tag = 200 + i;
        detailLabel.numberOfLines = 0;
        detailLabel.font = [UIFont systemFontOfSize:12.0f];
        NSString *str = arr[i];
        CGSize textSize = [str boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil].size;;
        [detailLabel setFrame:CGRectMake((Xmargin)*i-textSize.width/2+btnW/2, height *(1 - tempHeight)-30, textSize.width+15, textSize.height)];
        detailLabel.text = str;
//        detailLabel.textColor=[UIColor blueColor];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        [detailLabel setBackgroundColor:[UIColor colorWithRed:254/255.0 green:247/255.0 blue:237/255.0 alpha:1.0]];
        [detailLabel setLayerWidth:0.6f layerColor:[UIColor colorWithHexString:@"0xf38b10"] radius:2.0f];
        if (i == arr.count - 1) {
            detailLabel.hidden = NO;
        }else{
            detailLabel.hidden = YES;
        }
        [self.detailLabelArr addObject:detailLabel];
    }
    
}


-(void)addLeftViews{
    
    NSArray *leftArr = _dataArrOfY;
    
    for (int i = 0;i< _dataArrOfY.count ;i++ ) {
        
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, i*(Ymargin)+40-Ymargin/2, titleWOfY, Ymargin)];
        leftLabel.font = [UIFont systemFontOfSize:10.0f];
        leftLabel.textColor = [UIColor colorWithHexString:@"0xf38b10"];
//        leftLabel.backgroundColor=[UIColor redColor];
        leftLabel.textAlignment = NSTextAlignmentRight;
        leftLabel.text = leftArr[i];
        [self addSubview:leftLabel];
        
    }
    
    _titleOfY = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 20)];
    _titleOfY.font = [UIFont systemFontOfSize:10.0f];
    _titleOfY.textAlignment = kCTTextAlignmentCenter;
    _titleOfY.textColor = [UIColor colorWithHexString:@"0x999999"];
    _titleOfY.text = _titleOfYStr;
    [self addSubview:self.titleOfY];
    
}


-(void)addBottomViewsWith:(UIView *)UIView{
    
    NSArray *bottomArr;
    
    if (UIView == self.scrollBgView1) {
        bottomArr = _dataArrOfX;
        
    }else{
        //        bottomArr = @[@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月",@"七月"];
        
    }
    
    for (int i = 0;i< bottomArr.count ;i++ ) {
        
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(5+Xmargin/2+i*Xmargin, 6*Ymargin, Xmargin, 20)];
        leftLabel.font = [UIFont systemFontOfSize:10.0f];
        leftLabel.textColor = [UIColor colorWithHexString:@"0x999999"];
//        leftLabel.backgroundColor=[UIColor blueColor];
        leftLabel.text = bottomArr[i];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        [UIView addSubview:leftLabel];
        
    }
    
    
    _titleOfX = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.scrollBgView1.frame) + 30, CGRectGetMaxY(self.chartScrollView.frame) - 20, 30, 20)];
    _titleOfX.font = [UIFont systemFontOfSize:10.0f];
    _titleOfX.textAlignment = kCTTextAlignmentCenter;
    _titleOfX.textColor = [UIColor colorWithHexString:@"0x999999"];
    _titleOfX.text = _titleOfXStr;
    [self addSubview:self.titleOfX];
    
}



-(void)TopBtnAction:(UIButton *)sender{
    
    for (UIButton*btn in _leftBtnArr) {
        if (sender.tag == btn.tag) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    [self showDetailLabel:sender];
    
}

-(void)showDetailLabel:(UIButton *)sender{
    
    for (UILabel * label in _detailLabelArr) {
        if (sender.tag+200 == label.tag) {
            label.hidden = NO;
        }else{
            label.hidden = YES;
        }
    }
    
}





-(void)addLines1With:(UIView *)view{
    
    CGFloat magrginHeight = (view.bounds.size.height)/ 6;
    CGFloat labelWith = view.bounds.size.width;
    Ymargin = magrginHeight;
    //    NSLog(@"\n-------magrginHeight-------\n%f",magrginHeight);
    for (int i = 0;i<5 ;i++ ) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, magrginHeight+magrginHeight *i, labelWith, 1)];
        label.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        [view addSubview:label];
    }
    
    CGFloat marginWidth = view.bounds.size.width/_leftDataArr.count;
    Xmargin = marginWidth;
    //    NSLog(@"\n-------marginWidth-------\n%f",marginWidth);
    
    CGFloat labelHeight = view.bounds.size.height;
    
    for (int i = 0;i< _leftDataArr.count ;i++ ) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(marginWidth*i, 0, 1, labelHeight)];
        label.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        if (i != 0) {
            [view addSubview:label];
        }
    }
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    currentPage = scrollView.contentOffset.x/self.chartScrollView.bounds.size.width;
    self.pageControl.currentPage = currentPage;
}

@end
