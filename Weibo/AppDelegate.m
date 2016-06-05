//
//  AppDelegate.m
//  Weibo
//
//  Created by BinWu on 16/6/3.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "NewfeatureViewController.h"
#import "OAuthViewController.h"
#import "Account.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //判断有无账户模型数据
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    Account * account = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (account) {   //之前登录成功
        //取出沙盒中存储的上次软件版本
        NSString *key = @"CFBundleVersion";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *lastCode = [defaults stringForKey:key];
        //获取当前软件的版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
        if ([lastCode isEqualToString:currentVersion]) {
            self.window.rootViewController = [[TabBarViewController alloc] init];
        } else {
            self.window.rootViewController = [[NewfeatureViewController alloc] init];
            [defaults setObject:currentVersion forKey:key];
            [defaults synchronize];
        }
    } else {
        self.window.rootViewController = [[OAuthViewController alloc] init];
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark -weiboSDK
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
//    return [WeiboSDK handleOpenURL:url delegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [WeiboSDK handleOpenURL:url delegate:self];
//}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
