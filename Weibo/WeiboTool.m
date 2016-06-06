//
//  WeiboTools.m
//  Weibo
//
//  Created by BinWu on 16/6/6.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "WeiboTool.h"
#import "TabBarViewController.h"
#import "NewfeatureViewController.h"

@implementation WeiboTool
+ (void)chooseRootController{
    //取出沙盒中存储的上次软件版本
    NSString *key = @"CFBundleVersion";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastCode = [defaults stringForKey:key];
    //获取当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([lastCode isEqualToString:currentVersion]) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[TabBarViewController alloc] init];
    } else {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[NewfeatureViewController alloc] init];
        //存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }

}
@end
