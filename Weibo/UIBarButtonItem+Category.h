//
//  UIBarButtonItem+Category.h
//  Weibo
//
//  Created by BinWu on 16/6/4.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Category)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end
