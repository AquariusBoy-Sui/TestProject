//
//  NSData+Local.m
//  CatPregnent2
//
//  Created by ji long on 2019/11/22.
//  Copyright © 2019 Binky Lee. All rights reserved.
//

#import "NSDate+Local.h"

@implementation NSDate(Local)

/**
 获取年纪字符串
 */
+(NSDateComponents*)getAgeDateString:(NSDate*)birthDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDate *nowDate = [NSDate date];
    
    //用来得到详细的时差
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *date = [calendar components:unitFlags fromDate:birthDay toDate:nowDate options:0];
    return date;
}


+(NSArray*)getAgeDateArray:(NSDate*)birthDay{
    NSDateComponents *ageComponent=[self getAgeDateString:birthDay];
    NSString *ageUnit=nil;  //年纪单位
    NSString *ageStr=nil;
    if(ageComponent.year > 0 || ageComponent.month > 0)
    {
        if(ageComponent.year > 0 && ageComponent.month > 0)
        {
            ageStr=[NSString stringWithFormat:@"%ld年%ld个",ageComponent.year,ageComponent.month];
            ageUnit=@"月";
        }else if(ageComponent.month > 0)
        {
            ageStr=[NSString stringWithFormat:@"%ld个",ageComponent.month];
            ageUnit=@"月";
        }else if(ageComponent.year > 0 )
        {
            ageStr=[NSString stringWithFormat:@"%ld",ageComponent.year];
            ageUnit=@"岁";
        }
    }else{
        ageStr=[NSString stringWithFormat:@"%ld",ageComponent.day+1];
        ageUnit=@"天";
    }
    return @[ageStr,ageUnit];
}
/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    
    //已当天零点为准
    fromDate=[NSDate extractDate:fromDate];
    toDate=[NSDate extractDate:toDate];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateComponents    * comp = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:NSCalendarWrapComponents];
    return comp.day;
}


/**
 根据获取距离怀孕日期的期限
 */
+(int) getSubTodayNumber:(NSDate*)d
{   //这里
    NSTimeInterval oneDay = 24 * 60 * 60;  // 一天一共有多少秒1·
    NSDate *currentDate = [NSDate getCurrDate];
    currentDate=[NSDate extractDate:currentDate];
    d=[NSDate extractDate:d];
    NSTimeInterval secondsInterval= [currentDate timeIntervalSinceDate:d];
    int subDay=64-(int)(secondsInterval/oneDay);
    return subDay;
}

/**
 根据获取距离生日日期的期限
 */
+(int) getBirTodayNumber:(NSDate*)d
{   //这里
    NSTimeInterval oneDay = 24 * 60 * 60;  // 一天一共有多少秒
    NSDate *currentDate = [NSDate getCurrDate];
    NSTimeInterval secondsInterval= [currentDate timeIntervalSinceDate:d];
    int subDay=(int)(secondsInterval/oneDay);
    return subDay;
}

/**
 去掉日期的小时，分 ，秒，只返回日期
 */
+ (NSDate *)extractDate:(NSDate *)date {
     //get seconds since 1970
     NSTimeInterval interval = [date timeIntervalSince1970];
     int daySeconds = 24 * 60 * 60;
     //calculate integer type of days
     NSInteger allDays = interval / daySeconds;
     return [NSDate dateWithTimeIntervalSince1970:allDays * daySeconds];
}



/**
 计算俩个日期时间的差距
 */
+ (NSString *)getTimeYMDStartDate:(NSDate*)startDate endDate:(NSDate*)endDate {
    //时间格式转换器
    //分别转换为北京时间
    startDate = [startDate dateByAddingTimeInterval:8 * 60 * 60];
    //去掉小时，分，秒
    startDate=[NSDate extractDate:startDate];
    endDate = [endDate dateByAddingTimeInterval:8 * 60 * 60];
    endDate=[NSDate extractDate:endDate];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    //用来得到详细的时差
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *ageComponent = [calendar components:unitFlags fromDate:startDate toDate:endDate options:0];
    NSString *resultString=@"";
    if (ageComponent.year == 0 && ageComponent.month == 0 && ageComponent.day == 0) {
        resultString=@"当天";
    }
    if (ageComponent.year > 0 ) {
        if (ageComponent.month == 0 && ageComponent.day == 0) {
            resultString=[NSString stringWithFormat:@"%ld岁",ageComponent.year];
        }
        if (ageComponent.month == 0 && ageComponent.day > 0) {
            resultString=[NSString stringWithFormat:@"%ld年零%ld天",ageComponent.year,ageComponent.day];
        }
        
        if (ageComponent.month > 0 && ageComponent.day == 0) {
            resultString=[NSString stringWithFormat:@"%ld年零%ld个月",ageComponent.year,ageComponent.month];
        }
        if (ageComponent.month > 0 && ageComponent.day > 0) {
            resultString=[NSString stringWithFormat:@"%ld年%ld个月零%ld天",ageComponent.year,ageComponent.month,ageComponent.day];
        }
    }else if(ageComponent.month > 0){
        if (ageComponent.day>0 ) {
            resultString=[NSString stringWithFormat:@"%ld个月%ld天",ageComponent.month,ageComponent.day];
        }else{
            resultString=[NSString stringWithFormat:@"%ld个月",ageComponent.month];
        }
    }else if (ageComponent.day >0){
        resultString=[NSString stringWithFormat:@"%ld天",ageComponent.day];
    }
    if(ageComponent.year < 0 || ageComponent.month < 0 || ageComponent.day < 0)
    {
        resultString=@"超期";
    }

    return resultString;
}

+(NSString*)getYmdDateString:(NSDate*)birthDay{
    // 1年3个月+  3月+  20天
    NSDate *startDate = [birthDay dateByAddingTimeInterval:8 * 60 * 60];
    //去掉小时，分，秒
    startDate=[NSDate extractDate:startDate];
    NSDate *endDate = [[NSDate date] dateByAddingTimeInterval:8 * 60 * 60];
    endDate=[NSDate extractDate:endDate];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    //用来得到详细的时差
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *ageComponent = [calendar components:unitFlags fromDate:startDate toDate:endDate options:0];
    
    NSString *resultString=@"";
    if (ageComponent.year == 0 && ageComponent.month == 0 && ageComponent.day == 0) {
        resultString=@"当天";
    }
    if (ageComponent.year > 0 ) {
        if (ageComponent.month == 0 && ageComponent.day == 0) {
            resultString=[NSString stringWithFormat:@"%ld岁",ageComponent.year];
        }
        if (ageComponent.month == 0 && ageComponent.day > 0) {
            resultString=[NSString stringWithFormat:@"%ld年+",ageComponent.year];
        }
        if (ageComponent.month > 0 && ageComponent.day == 0) {
            resultString=[NSString stringWithFormat:@"%ld年%ld个月+",ageComponent.year,ageComponent.month];
        }
        if (ageComponent.month > 0 && ageComponent.day > 0) {
            resultString=[NSString stringWithFormat:@"%ld年%ld个月+",ageComponent.year,ageComponent.month];
        }
    }else if(ageComponent.month > 0){
        if (ageComponent.day>0 ) {
            resultString=[NSString stringWithFormat:@"%ld个月+",ageComponent.month];
        }else{
            resultString=[NSString stringWithFormat:@"%ld个月",ageComponent.month];
        }
    }else if (ageComponent.day >0){
        resultString=[NSString stringWithFormat:@"%ld天",ageComponent.day];
    }
    //都不是就是未出生
    if(resultString.length==0)
    {
        resultString=@"未出生";
    }
    return resultString;
}
/**
 获取当前时间
 */
+(NSDate*) getCurrDate
{
    if (@available(iOS 13.0, *)) {
        return [NSDate now];
    }
    // 得到当前时间（世界标准时间 UTC/GMT）
    NSDate *nowDate = [NSDate date];
    // 设置系统时区为本地时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    // 在 GMT 时间基础上追加时间差值，得到本地时间
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    return  nowDate;
}

/**
 获取当天唯一的NSDate
 */
+(NSDate*)getCurrDateDay
{
    NSInteger currDay=[NSDate getCurrDayTimeIntervalSince];
    return [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:(NSTimeInterval)currDay];
}


/**
 获取当前天的唯一天数
 */
+(NSInteger) getCurrDayTimeIntervalSince{
    NSDate* currData=[NSDate getCurrDate];
    NSTimeInterval since=[currData timeIntervalSince1970]*1000;
    NSInteger dayInterval=24*60*60;
    NSTimeInterval dayValue=((int)(since/dayInterval))*dayInterval;
    return dayValue;
}

/**
获取当前零点数据
*/
+(NSDate *)zeroOfDate
{
   
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    // 在 GMT 时间基础上追加时间差值，得到本地时间
    startDate = [startDate dateByAddingTimeInterval:interval];
    return startDate;
    
}



-(NSString*) getStringTimeIntervalSince1970
{
    return [NSString stringWithFormat:@"%ld",(long)([self timeIntervalSince1970]*1000)];
}



/**
 获取当前年份
 */
+(NSInteger) getCurrYear{
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];

    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    return currentYear;
}
/**
 获取当前月份
 */
+(NSInteger) getCurrMonth{
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    return currentMonth;
}
/**
 获取当前日期
 */
+(NSInteger) getCurrDay{
    NSDate *date =[NSDate date];//简书 FlyElephant
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];

    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:date] integerValue];
    return currentDay;
}

/**
 打印时间
 */
-(void)logDate{
    NSDate *date = [NSDate date];
    NSLog(@"直接使用NSDate获取的时间：%@", date);
    //使用formatter格式化后的时间
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    NSString *time_now = [formatter stringFromDate:date];
    NSLog(@"格式化后的时间%@", time_now);
    
    //在GMT时间上加上8个小时后的时间
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger sec = [zone secondsFromGMTForDate:date];
    NSDate *new_date = [date dateByAddingTimeInterval:sec];
    NSLog(@"在GMT时间上加上时间差之后的时间:%@", new_date);
    
    
    
    //如果在加上时间差后的时间上面再进行格式化的话，时间有误差
    NSString *time_other = [formatter stringFromDate:new_date];
    NSLog(@"加上时间差后再进行一次格式化后的时间：%@", time_other);
}

/**
 获取最后日期列表
 */
+(NSArray<NSDate*>*)getLastZeroDate:(NSInteger)dayNum{
    NSMutableArray<NSDate*>* listDay=[NSMutableArray new];
    NSDate *date = [NSDate zeroOfDate];//当前时间
    
    for(int i=(int)dayNum; i>0 ; i--)
    {
        NSDate *day = [NSDate dateWithTimeInterval:-24*60*60*i sinceDate:date];
        [listDay addObject:day];
    }
    
    [listDay addObject:date];
    return listDay;
}

/**
 根据天数获取下一间隔日期
 */
+(NSDate*)getDateForDay:(NSDate*)mydate withDay:(NSInteger)day
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    return newdate;
    
}


/**
 是否为同一天
 */
+(BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}

/**
 获取当月第一天及最后一天
 */
+(NSArray *)getMonthFirstAndLastDayWith:(NSString *)dateStr{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年M月"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @[@"",@""];
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *firstString = [myDateFormatter stringFromDate: firstDate];
//    NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    return @[firstDate, lastDate];
}



@end
