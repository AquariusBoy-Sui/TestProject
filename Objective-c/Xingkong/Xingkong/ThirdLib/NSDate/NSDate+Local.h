//
//  NSData+Local.h
//  CatPregnent2
//  
//  Created by ji long on 2019/11/22.
//  Copyright © 2019 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate(Local)

+(NSDateComponents*)getAgeDateString:(NSDate*)birthDay;                 //获取年纪字符串
+(NSString*)getYmdDateString:(NSDate*)birthDay;
+(NSArray*)getAgeDateArray:(NSDate*)birthDay;                           //获取年纪数组(day,year,month,unit)
+(NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate; //获取两个日期之间的天数
+(int) getSubTodayNumber:(NSDate*)d;    //获取与今天日期距离多少天
+(int) getBirTodayNumber:(NSDate*)d;    //获取与今天日期距离多少天

+(NSDate*) getCurrDate;                   //获取当前时间
+(NSDate*) getCurrDateDay;                //获取当天唯一的NSDate for 00:00:00
+(NSInteger) getCurrYear;                 //获取当前年份
+(NSInteger) getCurrMonth;                //获取当前月份
+(NSInteger) getCurrDay;                  //获取当前日期
+(NSInteger) getCurrDayTimeIntervalSince; //获取当天的Interval
+(NSDate *)zeroOfDate;                    //获取零点数据
+(NSArray<NSDate*>*)getLastZeroDate:(NSInteger)dayNum;  //获取最后日期列表

+(NSDate*)getDateForDay:(NSDate*)date withDay:(NSInteger)day;     //根据天数获取指定下一间隔日期;
+(BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2;           // 判断是否是同一天
+(NSArray *)getMonthFirstAndLastDayWith:(NSString *)dateStr;      //
-(NSString*) getStringTimeIntervalSince1970;

+ (NSString *)getTimeYMDStartDate:(NSDate*)startDate endDate:(NSDate*)endDate; // 日期 距今 年月日

+ (NSDate *)extractDate:(NSDate *)date; //去掉日期的小时，分 ，秒，只返回日期
@end

NS_ASSUME_NONNULL_END

