//
//  NSString+FormmatDate.m
//  MyCategoriesCollection
//
//  Created by AD-iOS on 16/3/10.
//  Copyright © 2016年 DW. All rights reserved.
//

#import "NSString+FormmatDate.h"

@implementation NSString (FormmatDate)


+(NSString *)formmatDate:(NSString *)paramTime{
    
    if (paramTime.length==0) {
        return @"";
    }
    NSString *dateStr=paramTime;
    NSCalendar *gregorian = [[ NSCalendar alloc ] initWithCalendarIdentifier : NSGregorianCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute ;
    NSDateFormatter *format=[[ NSDateFormatter alloc ] init ];
    [format setDateFormat : @"yyyy/MM/dd HH:mm:ss" ];
    NSDate *fromdate=[format dateFromString :dateStr];
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:fromdate];
    // DDLog(@"%lu-%lu-%lu-%lu",[components month],[components day],[components hour],[components minute]);
    NSDateComponents *nowComponets = [gregorian components:unitFlags fromDate:[NSDate date]];
    // DDLog(@"%lu-%lu-%lu-%lu",[nowComponets month],[nowComponets day],[nowComponets hour],[nowComponets minute]);
    
    //返回的时间
    NSInteger year = [components year];
    NSInteger months = [components month];
    NSInteger days = [components day];
    NSInteger minute = [components minute];
    NSInteger hour = [components hour];
    
    //今天的时间
    NSInteger nowMonths = [nowComponets month];
    NSInteger nowDays = [nowComponets day];
    //    NSInteger nowMinute = [nowComponets minute];
    //    NSInteger nowHour = [nowComponets hour];
    NSString *strHour = hour < 10?[NSString stringWithFormat:@"0%lu",(long)hour]:[NSString stringWithFormat:@"%lu",(long)hour];
    NSString *strMinute = minute < 10?[NSString stringWithFormat:@"0%lu",(long)minute]:[NSString stringWithFormat:@"%lu",(long)minute];
    NSString *strMonth = months < 10?[NSString stringWithFormat:@"0%lu",(long)months]:[NSString stringWithFormat:@"%lu",(long)months];
    NSString *strDay = days < 10?[NSString stringWithFormat:@"0%lu",(long)days]:[NSString stringWithFormat:@"%lu",(long)days];
    NSString *strYear = year < 10?[NSString stringWithFormat:@"0%lu",(long)year]:[NSString stringWithFormat:@"%lu",(long)year];
    if (months == nowMonths && days == nowDays) {
        dateStr = [NSString stringWithFormat:@"今天 %@:%@",strHour,strMinute];
    }else if (months == nowMonths && (nowDays - days == 1)){
        dateStr = [NSString stringWithFormat:@"昨天 %@:%@",strHour,strMinute];
    }else{
        dateStr = [NSString stringWithFormat:@"%@-%@-%@",strYear,strMonth,strDay];
    }
    
    return dateStr;
}

@end
