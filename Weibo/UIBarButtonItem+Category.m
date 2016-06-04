//
//  UIBarButtonItem+Category.m
//  Weibo
//
//  Created by BinWu on 16/6/4.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "UIBarButtonItem+Category.h"

@implementation UIBarButtonItem (Category)


+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    btn.bounds = (CGRect){CGPointZero,btn.currentBackgroundImage.size};
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
