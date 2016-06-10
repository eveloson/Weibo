//
//  NSDate+Category.m
//  Weibo
//
//  Created by BinWu on 16/6/9.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

- (BOOL)isToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    //1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    //2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:[NSDate date]];
    return selfCmps.year == nowCmps.year && selfCmps.month == nowCmps.month && selfCmps.day == nowCmps.day;
}
- (BOOL)isYesterday{
    return false;
}
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    //1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    //2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:[NSDate date]];
    return selfCmps.year == nowCmps.year;
}
- (NSDateComponents *)deltaWithNow{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}
@end
