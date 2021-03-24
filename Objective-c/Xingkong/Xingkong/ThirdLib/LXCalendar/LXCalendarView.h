//
//  LXCalendarView.h
//  LXCalendar
//
//  Created by chenergou on 2017/11/2.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXCalendarHearder;

typedef void (^SelectBlock) (NSInteger year ,NSInteger month ,NSInteger day);

@interface LXCalendarView : UIView
@property(nonatomic,strong)LXCalendarHearder *calendarHeader; //头部
@property(nonatomic,strong)UIColor *backColor;              //背景颜色
@property(nonatomic,strong)UIColor *currentMonthTitleColor; //当前月的title颜色
@property(nonatomic,strong)UIColor *lastMonthTitleColor;    //上月的title颜色
@property(nonatomic,strong)UIColor *nextMonthTitleColor;    //下月的title颜色
@property(nonatomic,strong)UIColor *selectBackColor;        //选中的背景颜色
@property(nonatomic,strong)UIColor *todayTitleColor;        //今日的title颜色
@property(nonatomic,strong)NSMutableDictionary<NSDate*,UIColor*> *roundColorDict;    //需要设置颜色的日期字典
@property(nonatomic,assign)BOOL     isHaveAnimation;        //选中的是否动画效果
@property(nonatomic,assign)BOOL     isCanScroll;            //是否禁止手势滚动
@property(nonatomic,assign)BOOL     isShowLastAndNextBtn;   //是否显示上月，下月的按钮
@property(nonatomic,assign)BOOL     isShowLastAndNextDate;  //是否显示上月，下月的的数据
@property(nonatomic,copy)SelectBlock selectBlock;           //选中的回调

-(void)setup;                                               //初始化执行
-(void)dealData;                                            //在配置好上面的属性之后执行
-(void)setDayRedColor:(NSInteger)year mon:(NSInteger)month day:(NSInteger)day;  //设置日期颜色
-(void)addDateColor:(NSDate*)date withColor:(UIColor*)color;  //增加日期颜色
-(void)clearDateColor;                                        //清空日期颜色

@end
