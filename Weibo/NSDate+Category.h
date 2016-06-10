//
//  NSDate+Category.h
//  Weibo
//
//  Created by BinWu on 16/6/9.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

- (BOOL)isToday;

- (BOOL)isYesterday;

- (BOOL)isThisYear;
- (NSDateComponents *)deltaWithNow;
@end
