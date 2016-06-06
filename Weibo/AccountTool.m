//
//  AccountTool.m
//  Weibo
//
//  Created by BinWu on 16/6/6.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "AccountTool.h"
#import "Account.h"
#define kAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.data"]
@implementation AccountTool
+ (void)saveAccount:(Account *)account{
    NSDate *now = [NSDate date];
    account.expireTime = [now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountFile];
}
+ (Account *)account{
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountFile];
    //判断账号是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expireTime] == kCFCompareLessThan) {
        return account;
    } else {
        return nil;
    }
}
@end
