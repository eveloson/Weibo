//
//  AccountTool.h
//  Weibo
//
//  Created by BinWu on 16/6/6.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Account;
@interface AccountTool : NSObject
+ (void)saveAccount:(Account *)account;
+ (Account *)account;
@end
