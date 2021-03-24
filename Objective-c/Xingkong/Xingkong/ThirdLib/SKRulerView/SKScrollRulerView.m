//
//  SKScrollRulerView.m
//  0002
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SKScrollRulerView.h"
#import "SKRulerViewConfiguration.h"
#import "SKRulerView.h"



@interface SKScrollRulerView ()<UICollectionViewDelegate,UICollectionViewDataSource>



///刻度指针
@property (nonatomic ,strong)SKTriangleView * triangleView;
///刻度条数
@property (nonatomic ,assign)NSInteger stepNum;


@end


@implementation SKScrollRulerView


- (instancetype)initWithFrame:(CGRect)frame theMinValue:(NSInteger)minValue theMaxValue:(NSInteger)maxValue theStep:(CGFloat)step theRulerGap:(CGFloat)rulerGap theMaxThresholdValue:(CGFloat)maxThresholdValue theMinThresholdValue:(CGFloat)minThresholdValue{
    
    self = [super initWithFrame:frame];
    if (self) {
        SKShareConfiguration.minValue = minValue;
        SKShareConfiguration.maxValue = maxValue;
        SKShareConfiguration.step = step;
        SKShareConfiguration.rulerGap = rulerGap;
        SKShareConfiguration.maxThresholdValue = maxThresholdValue;
        SKShareConfiguration.minThresholdValue = minThresholdValue;
        self.stepNum = (SKShareConfiguration.maxValue - SKShareConfiguration.minValue)/SKShareConfiguration.step/10;
        [self lazyCollectionView];
        [self addSubview:self.collectionView];
        [self lazyTriangleView];
        
        [self addSubview:self.triangleView];
        [self drawRect:frame];
        
    }
    return self;
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.stepNum = (SKShareConfiguration.maxValue - SKShareConfiguration.minValue)/SKShareConfiguration.step/10;
        [self lazyCollectionView];
        [self addSubview:self.collectionView];
        [self lazyTriangleView];
        
        [self addSubview:self.triangleView];
        [self drawRect:frame];
        self.backgroundColor = [UIColor clearColor];
    }
    
    
    return self;
}

- (void)lazyTriangleView{
    if (!_triangleView) {
        _triangleView = [[SKTriangleView alloc]initWithFrame:CGRectMake(self.bounds.size.width / 2 - SKShareConfiguration.triangle_w / 2, 0, SKShareConfiguration.triangle_w, SKShareConfiguration.triangle_h)];
        _triangleView.backgroundColor = [UIColor clearColor];
    }
}

- (void)lazyCollectionView{
    if (!_collectionView) {
        CGFloat width = self.bounds.size.width;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-SKShareConfiguration.ruler_h, width, SKShareConfiguration.ruler_h) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.bounces = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator= NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[HeaderCell class] forCellWithReuseIdentifier:@"HeaderCell"];
        [_collectionView registerClass:[FooterCell class] forCellWithReuseIdentifier:@"FooterCell"];
        [_collectionView registerClass:[LowerThanScaleViewCell class] forCellWithReuseIdentifier:@"LowerThanScaleViewCell"];
        [_collectionView registerClass:[NormalScaleViewCell class] forCellWithReuseIdentifier:@"NormalScaleViewCell"];
        
        [_collectionView registerClass:[PartBeyondScaleViewCell class] forCellWithReuseIdentifier:@"PartBeyondScaleViewCell"];
        [_collectionView registerClass:[BeyondScaleViewCell class] forCellWithReuseIdentifier:@"BeyondScaleViewCell"];
    }
}




#pragma mark ===============collectionViewDelegate&DataSource===============

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.stepNum+2;//左右占位
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        HeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else if (indexPath.row == self.stepNum+1){
        FooterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FooterCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.numberlabel.text = [NSString stringWithFormat:@"%0.f",(indexPath.row-1)*SKShareConfiguration.step*10 + SKShareConfiguration.minValue];
        return cell;
    }else{
        if (indexPath.row < (SKShareConfiguration.minThresholdValue - SKShareConfiguration.minValue)/SKShareConfiguration.step/10) {
            BeyondScaleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BeyondScaleViewCell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor clearColor];
            cell.numberlabel.text = [NSString stringWithFormat:@"%0.f",(indexPath.row-1)*SKShareConfiguration.step*10 + SKShareConfiguration.minValue];
            
            return cell;
        }else if (indexPath.row >= (SKShareConfiguration.minThresholdValue - SKShareConfiguration.minValue)/SKShareConfiguration.step/10 && indexPath.row < (SKShareConfiguration.minThresholdValue - SKShareConfiguration.minValue)/SKShareConfiguration.step/10+1){
            
            LowerThanScaleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LowerThanScaleViewCell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor clearColor];
            cell.numberlabel.text = [NSString stringWithFormat:@"%0.f",(indexPath.row-1)*SKShareConfiguration.step*10 + SKShareConfiguration.minValue];
            
            return cell;
            
        }else if (indexPath.row > (SKShareConfiguration.maxThresholdValue - SKShareConfiguration.minValue)/SKShareConfiguration.step/10 && indexPath.row <= (SKShareConfiguration.maxThresholdValue - SKShareConfiguration.minValue)/SKShareConfiguration.step/10+1){
            
            PartBeyondScaleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PartBeyondScaleViewCell" forIndexPath:indexPath];
            cell.numberlabel.text = [NSString stringWithFormat:@"%0.f",(indexPath.row-1)*SKShareConfiguration.step*10 + SKShareConfiguration.minValue];
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }else if (indexPath.row > (SKShareConfiguration.maxThresholdValue - SKShareConfiguration.minValue)/SKShareConfiguration.step/10 + 1){
            BeyondScaleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BeyondScaleViewCell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor clearColor];
            cell.numberlabel.text = [NSString stringWithFormat:@"%0.f",(indexPath.row-1)*SKShareConfiguration.step*10 + SKShareConfiguration.minValue];
            
            return cell;
            
        }else{
            
            NormalScaleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalScaleViewCell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor clearColor];
            cell.numberlabel.text = [NSString stringWithFormat:@"%0.f",(indexPath.row-1)*SKShareConfiguration.step*10 + SKShareConfiguration.minValue];
            
            return cell;
        }
        
        
        
        
//
//        if (indexPath.row <= (SKShareConfiguration.maxThresholdValue - SKShareConfiguration.minValue)/SKShareConfiguration.step/10) {
//            NormalScaleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalScaleViewCell" forIndexPath:indexPath];
//            cell.backgroundColor = [UIColor clearColor];
//            cell.numberlabel.text = [NSString stringWithFormat:@"%0.f",(indexPath.row-1)*SKShareConfiguration.step*10 + SKShareConfiguration.minValue];
//
//            return cell;
//        }else if(indexPath.row > (SKShareConfiguration.maxThresholdValue - SKShareConfiguration.minValue)/SKShareConfiguration.step/10 + 1){
//            BeyondScaleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BeyondScaleViewCell" forIndexPath:indexPath];
//            cell.backgroundColor = [UIColor clearColor];
//            cell.numberlabel.text = [NSString stringWithFormat:@"%0.f",(indexPath.row-1)*SKShareConfiguration.step*10 + SKShareConfiguration.minValue];
//
//            return cell;
//        }else{
//
//            PartBeyondScaleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PartBeyondScaleViewCell" forIndexPath:indexPath];
//            cell.numberlabel.text = [NSString stringWithFormat:@"%0.f",(indexPath.row-1)*SKShareConfiguration.step*10 + SKShareConfiguration.minValue];
//            cell.backgroundColor = [UIColor clearColor];
//            return cell;
//
//        }

    }
    
}


- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0 || indexPath.item == _stepNum + 1){
        return CGSizeMake(self.frame.size.width/ 2 , SKShareConfiguration.ruler_h);
    }else{
        
        return CGSizeMake(SKShareConfiguration.rulerGap*10, SKShareConfiguration.ruler_h);
    }
    
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}


#pragma mark =================UIScrollViewDelegate===================
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int value = scrollView.contentOffset.x / SKShareConfiguration.rulerGap;
    float totalValue = value*SKShareConfiguration.step + SKShareConfiguration.minValue;
    
    
    if (totalValue > SKShareConfiguration.maxValue) {
        totalValue = SKShareConfiguration.maxValue;
    }
    
    if (totalValue < SKShareConfiguration.minValue) {
        totalValue = SKShareConfiguration.minValue;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sbScrollRulerView:valueChange:)]) {
        [self.delegate sbScrollRulerView:self valueChange:totalValue];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{//拖拽时没有滑动动画
    if (!decelerate){
        [self setRealValue:round(scrollView.contentOffset.x/(SKShareConfiguration.rulerGap)) animated:YES];
    }
}

#pragma mark ===============设定滚动暂停位置===============
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setRealValue:round(scrollView.contentOffset.x/(SKShareConfiguration.rulerGap)) animated:YES];
}

- (void)setRealValue:(float)realValue animated:(BOOL)animated{
    [_collectionView setContentOffset:CGPointMake(realValue * SKShareConfiguration.rulerGap, 0) animated:animated];
}
#pragma mark ===============设置默认值===============
- (void)setDefaultValue:(float)defaultValue animated:(BOOL)animated{
    [_collectionView setContentOffset:CGPointMake((defaultValue - SKShareConfiguration.minValue)/SKShareConfiguration.step * SKShareConfiguration.rulerGap, 0) animated:animated];
}


@end
