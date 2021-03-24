//
//  LXCalendarWeekView.m
//  LXCalendar
//
//  Created by chenergou on 2017/11/2.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXCalendarWeekView.h"

@implementation LXCalendarWeekView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}
-(void)setWeekTitles:(NSArray *)weekTitles{
    _weekTitles = weekTitles;
    //周标题xxxx年xx月下边的ui部分
    CGFloat width = self.lx_width /weekTitles.count;
    for (int i = 0; i< weekTitles.count; i++) {
        UILabel *weekLabel =[UILabel LXLabelWithText:weekTitles[i] textColor:self.labelColor backgroundColor:self.backgroundColor frame:CGRectMake(i * width, 0, width, self.lx_height) font:Font(14) textAlignment:NSTextAlignmentCenter];
        weekLabel.backgroundColor =self.backgroundColor;
        [self addSubview:weekLabel];
    }
}
@end
