//
//  Status.m
//  Weibo
//
//  Created by BinWu on 16/6/6.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "Status.h"
#import "NSDate+Category.h"
#import "Photo.h"
#import <MJExtension.h>
@implementation Status

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : [Photo class]};
}

- (NSString *)created_at{
    //               "created_at" = "Wed Jun 08 11:51:54 +0800 2016";
    //1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setTimeZone:[NSTimeZone systemTimeZone]];
    [fmt setLocale:[NSLocale currentLocale]];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    //2.判断微博发送时间和现在时间的差距
    if (createDate.isToday) {
        if (createDate.deltaWithNow.hour >= 1 ) {
            return [NSString stringWithFormat:@"%ld小时前",createDate.deltaWithNow.hour];
        } else if (createDate.deltaWithNow.minute >= 1){
            return [NSString stringWithFormat:@"%ld分钟前",createDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createDate.isYesterday){
        return @"昨天 HH:mm";

    } else if (createDate.isThisYear){
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    } else {
        //非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];

    }
}
- (void)setSource:(NSString *)source
{
    int loc = [source rangeOfString:@">"].location + 1;
    int length = [source rangeOfString:@"</"].location - loc;
    source = [source substringWithRange:NSMakeRange(loc, length)];
    
    _source = [NSString stringWithFormat:@"来自%@", source];
}
//- (instancetype)initWithDict:(NSDictionary *)dict{
//    if (self = [super init]) {
//        self.idstr = dict[@"idstr"];
//        self.text = dict[@"text"];
//        self.source = dict[@"source"];
//        self.reposts_count = [dict[@"reposts_count"] intValue];
//        self.comments_count = [dict[@"comments_count"] intValue];
//        self.user = [User userWithDict:dict[@"user"]];
//        
//    }
//    
//    return self;
//}
//+ (instancetype)statusWithDict:(NSDictionary *)dict{
//    return [[self alloc] initWithDict:dict];
//}
@end
