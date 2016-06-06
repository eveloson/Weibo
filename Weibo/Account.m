//
//  Account.m
//  Weibo
//
//  Created by BinWu on 16/6/5.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "Account.h"

@implementation Account
+ (instancetype)accountWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expireTime = [aDecoder decodeObjectForKey:@"expireTime"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expireTime forKey:@"expireTime"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
}
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
