//
//  LXCalendarView.m
//  LXCalendar
//  修改当日动画
//  Created by chenergou on 2017/11/2.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXCalendarView.h"
#import "LXCalendarHearder.h"
#import "LXCalendarWeekView.h"
#import "LXCalenderCell.h"
#import "LXCalendarMonthModel.h"
#import "NSDate+GFCalendar.h"
#import "LXCalendarDayModel.h"
@interface LXCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)LXCalendarWeekView *calendarWeekView;//周
@property(nonatomic,strong)UICollectionView *collectionView;//日历
@property(nonatomic,strong)NSMutableArray *monthdataA;//当月的模型集合
@property(nonatomic,strong)NSDate *currentMonthDate;//当月的日期
@property(nonatomic,strong)UISwipeGestureRecognizer *leftSwipe;//左滑手势
@property(nonatomic,strong)UISwipeGestureRecognizer *rightSwipe;//右滑手势


@end
@implementation LXCalendarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentMonthDate = [NSDate date];
    }
    return self;
}
-(void)dealData{
    
    
    [self responData];
}
-(void)setup{
    [self addSubview:self.calendarHeader];
    
    WeakSelf(weakSelf);
    self.calendarHeader.leftClickBlock = ^{
        [weakSelf rightSlide];
    };
    
    self.calendarHeader.rightClickBlock = ^{
        [weakSelf leftSlide];
        
    };
    [self addSubview:self.calendarWeekView];
    
    [self addSubview:self.collectionView];
    self.lx_height = self.collectionView.lx_bottom;
    
    
    //添加左滑右滑手势
    self.leftSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.collectionView addGestureRecognizer:self.leftSwipe];
    
    self.rightSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.collectionView addGestureRecognizer:self.rightSwipe];
}
#pragma mark --左滑手势--
-(void)leftSwipe:(UISwipeGestureRecognizer *)swipe{
    
    [self leftSlide];
}
#pragma mark --左滑处理--
-(void)leftSlide{
    self.currentMonthDate = [self.currentMonthDate nextMonthDate];
    
    [self performAnimations:kCATransitionFromRight];
    [self responData];
}
#pragma mark --右滑处理--
-(void)rightSlide{
    
    self.currentMonthDate = [self.currentMonthDate previousMonthDate];
    [self performAnimations:kCATransitionFromLeft];
    
    [self responData];
}
#pragma mark --右滑手势--
-(void)rightSwipe:(UISwipeGestureRecognizer *)swipe{
    
    [self rightSlide];
}
#pragma mark--动画处理--
- (void)performAnimations:(NSString *)transition{
    CATransition *catransition = [CATransition animation];
    catransition.duration = 0.5;
    [catransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    catransition.type = kCATransitionPush; //choose your animation
    catransition.subtype = transition;
    [self.collectionView.layer addAnimation:catransition forKey:nil];
}

#pragma mark--数据以及更新处理--
-(void)responData{
    
    [self.monthdataA removeAllObjects];
    
    NSDate *previousMonthDate = [self.currentMonthDate previousMonthDate];
    
    NSDate *nextMonthDate = [self.currentMonthDate  nextMonthDate];
    
    LXCalendarMonthModel *monthModel = [[LXCalendarMonthModel alloc]initWithDate:self.currentMonthDate];
    
    LXCalendarMonthModel *lastMonthModel = [[LXCalendarMonthModel alloc]initWithDate:previousMonthDate];
    
    LXCalendarMonthModel *nextMonthModel = [[LXCalendarMonthModel alloc]initWithDate:nextMonthDate];
    
    self.calendarHeader.dateStr = [NSString stringWithFormat:@"%ld年%ld月",monthModel.year,monthModel.month];
    
    NSInteger firstWeekday = monthModel.firstWeekday;
    
    NSInteger totalDays = monthModel.totalDays;
    NSInteger currMonth=[[NSDate date] dateMonth];  //当前月份
    NSInteger currYear=[[NSDate date] dateYear];    //当前年份
    NSInteger currDay=[[NSDate date] dateDay];      //今天
    
    NSArray * allColorKeys=[self.roundColorDict allKeys];
    for (int i = 0; i <42; i++) {
        
        LXCalendarDayModel *model =[[LXCalendarDayModel alloc]init];
        
        //配置外面属性
        [self configDayModel:model];
        
        model.firstWeekday = firstWeekday;
        model.totalDays = totalDays;
        
        model.month = monthModel.month;
        
        model.year = monthModel.year;
        
        
        //上个月的日期
        if (i < firstWeekday) {
            model.day = lastMonthModel.totalDays - (firstWeekday - i) + 1;
            model.isLastMonth = YES;
        }
        
        //当月的日期
        if (i >= firstWeekday && i < (firstWeekday + totalDays)) {
            //i代表的天数
            NSInteger iDay=i -firstWeekday +1;
            model.day = iDay;
            model.isCurrentMonth = YES;
            
            //标识是今天
            if ((monthModel.month == currMonth) && (monthModel.year == currYear) && iDay==currDay) {
                    model.isToday = YES;
                    model.isSelected=YES;
                    model.isHaveAnimation=YES;
                
            }
            //查找是否有圆的颜色
            model.roundColor=nil;
            
            for(int i=0; i< allColorKeys.count ;i++)
            {
                NSDate *dateKey=allColorKeys[i];
                if (monthModel.month == [dateKey dateMonth] && monthModel.year == [dateKey dateYear] && iDay == [dateKey dateDay])
                {
                    model.roundColor=[self.roundColorDict objectForKey:dateKey];
                    break;
                }
            }
           
        }
        //下月的日期
        if (i >= (firstWeekday + monthModel.totalDays)) {
            
            model.day = i -firstWeekday - nextMonthModel.totalDays +1;
            model.isNextMonth = YES;
            
        }
        
        [self.monthdataA addObject:model];
        
    }
    
    [self.collectionView reloadData];
    
}

/**
 增加日期颜色
 */
-(void)addDateColor:(NSDate*)date withColor:(UIColor*)color{
    if(!self.roundColorDict)
        self.roundColorDict=[NSMutableDictionary new];
    [self.roundColorDict setObject:color forKey:date];
}

/**
 清空日期颜色
 */
-(void)clearDateColor{
    if(!self.roundColorDict) return;
    [self.roundColorDict removeAllObjects];
}

-(void)configDayModel:(LXCalendarDayModel *)model{
    
    
    //配置外面属性
    model.isHaveAnimation = self.isHaveAnimation;
    
    model.currentMonthTitleColor = self.currentMonthTitleColor;
    
    model.lastMonthTitleColor = self.lastMonthTitleColor;
    
    model.nextMonthTitleColor = self.nextMonthTitleColor;
    
    model.selectBackColor = self.selectBackColor;
    
    model.isHaveAnimation = self.isHaveAnimation;
    
    model.todayTitleColor = self.todayTitleColor;
    
    model.isShowLastAndNextDate = self.isShowLastAndNextDate;
    
    model.backColor= self.backColor;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.monthdataA.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIndentifier = @"cell";
    LXCalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    if (!cell) {
        cell =[[LXCalenderCell alloc]init];
        
    }
    
    cell.model = self.monthdataA[indexPath.row];
    
    cell.backgroundColor =self.backColor;
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    LXCalendarDayModel *model = self.monthdataA[indexPath.row];
    model.isSelected = YES;
    
    [self.monthdataA enumerateObjectsUsingBlock:^(LXCalendarDayModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj != model) {
            obj.isSelected = NO;
        }
    }];
    
    if (self.selectBlock) {
        self.selectBlock(model.year, model.month, model.day);
    }
    
    [collectionView reloadData];
}




/**
 设置日期颜色
 */
-(void)setDayRedColor:(NSInteger)year mon:(NSInteger)month day:(NSInteger)day
{
    [self.monthdataA enumerateObjectsUsingBlock:^(LXCalendarDayModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.year==year && obj.month==month && obj.day==day) {
            obj.isSelected = YES;
        }else{
            obj.isSelected = NO;
        }
    }];
    [self.collectionView reloadData];
}


-(void)layoutSubviews{
    //白条部分ui 头像下到日期上部分
    [super layoutSubviews];
    self.calendarHeader.frame = CGRectMake(0, 0, self.lx_width, 50);
}
#pragma mark---懒加载
-(LXCalendarHearder *)calendarHeader{
    if (!_calendarHeader) {
        _calendarHeader =[LXCalendarHearder showView];
        //日期部分ui
        _calendarHeader.frame = CGRectMake(0, 0, self.lx_width, 50);
        _calendarHeader.backgroundColor =self.backColor;
        
    }
    return _calendarHeader;
}
-(LXCalendarWeekView *)calendarWeekView{
    if (!_calendarWeekView) {
        //一二三四五六日部分ui
        _calendarWeekView =[[LXCalendarWeekView alloc]initWithFrame:CGRectMake(0, self.calendarHeader.lx_bottom, self.lx_width, 50)];
        _calendarWeekView.backgroundColor=self.backColor;
        _calendarWeekView.labelColor=self.currentMonthTitleColor;
        _calendarWeekView.weekTitles = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        
    }
    return _calendarWeekView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow =[[UICollectionViewFlowLayout alloc]init];
        //325*403
        flow.minimumInteritemSpacing = 0;
        flow.minimumLineSpacing = 0;
        flow.sectionInset =UIEdgeInsetsMake(0 , 0, 0, 0);
        //日历主体ui
        flow.itemSize = CGSizeMake(self.lx_width/7, 38);
        //        if(model.day>30){
        //            NSLog(@"test");
        //
        //          _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, self.calendarWeekView.lx_bottom, self.lx_width, 6 * 40) collectionViewLayout:flow];
        //        }else{
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, self.calendarWeekView.lx_bottom, self.lx_width, 6 * 40) collectionViewLayout:flow];
        
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = YES;
        _collectionView.backgroundColor = self.backColor;
        UINib *nib = [UINib nibWithNibName:@"LXCalenderCell" bundle:nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
        
        
    }
    return _collectionView;
}
-(NSMutableArray *)monthdataA{
    if (!_monthdataA) {
        _monthdataA =[NSMutableArray array];
    }
    return _monthdataA;
}

/*
 * 当前月的title颜色
 */
-(void)setCurrentMonthTitleColor:(UIColor *)currentMonthTitleColor{
    _currentMonthTitleColor = currentMonthTitleColor;
}
/*
 * 上月的title颜色
 */
-(void)setLastMonthTitleColor:(UIColor *)lastMonthTitleColor{
    _lastMonthTitleColor = lastMonthTitleColor;
}
/*
 * 下月的title颜色
 */
-(void)setNextMonthTitleColor:(UIColor *)nextMonthTitleColor{
    _nextMonthTitleColor = nextMonthTitleColor;
}

/*
 * 选中的背景颜色
 */
-(void)setSelectBackColor:(UIColor *)selectBackColor{
    _selectBackColor = selectBackColor;
}

/*
 * 选中的是否动画效果
 */

-(void)setIsHaveAnimation:(BOOL)isHaveAnimation{
    
    _isHaveAnimation  = isHaveAnimation;
}

/*
 * 是否禁止手势滚动
 */
-(void)setIsCanScroll:(BOOL)isCanScroll{
    _isCanScroll = isCanScroll;
    
    self.leftSwipe.enabled = self.rightSwipe.enabled = isCanScroll;
}

/*
 * 是否显示上月，下月的按钮
 */

-(void)setIsShowLastAndNextBtn:(BOOL)isShowLastAndNextBtn{
    _isShowLastAndNextBtn  = isShowLastAndNextBtn;
    self.calendarHeader.isShowLeftAndRightBtn = isShowLastAndNextBtn;
}


/*
 * 是否显示上月，下月的的数据
 */
-(void)setIsShowLastAndNextDate:(BOOL)isShowLastAndNextDate{
    _isShowLastAndNextDate =  isShowLastAndNextDate;
}
/*
 * 今日的title颜色
 */

-(void)setTodayTitleColor:(UIColor *)todayTitleColor{
    _todayTitleColor = todayTitleColor;
}
@end
