//
//  User.h
//  Weibo
//
//  Created by BinWu on 16/6/6.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 user: {
 id: 1850988623,
 idstr: "1850988623",
 class: 1,
 screen_name: "果壳网",
 name: "果壳网",
 province: "11",
 city: "5",
 location: "北京 朝阳区",
 description: "果壳网（Guokr.com）是开放、多元的泛科技兴趣社区，并提供负责任、有智趣的科技主题内容。",
 url: "http://www.guokr.com",
 profile_image_url: "http://tva3.sinaimg.cn/crop.0.0.798.798.50/6e53d84fjw1emxsjasvj7j20m80m8gmw.jpg",
 cover_image: "http://ww2.sinaimg.cn/crop.0.0.920.300/6e53d84fjw1emyttj2zcqj20pk08cgoi.jpg",
 cover_image_phone: "http://ww1.sinaimg.cn/crop.0.0.640.640.640/6ce2240djw1e9ob3xerqoj20hs0hsjur.jpg",
 profile_url: "guokr42",
 domain: "guokr42",
 weihao: "",
 gender: "m",
 followers_count: 5095961,
 friends_count: 1969,
 pagefriends_count: 30,
 statuses_count: 33090,
 favourites_count: 44,
 created_at: "Sun Nov 07 20:02:12 +0800 2010",
 following: true,
 allow_all_act_msg: true,
 geo_enabled: true,
 verified: true,
 verified_type: 3,
 remark: "",
 ptype: 0,
 allow_all_comment: true,
 avatar_large: "http://tva3.sinaimg.cn/crop.0.0.798.798.180/6e53d84fjw1emxsjasvj7j20m80m8gmw.jpg",
 avatar_hd: "http://tva3.sinaimg.cn/crop.0.0.798.798.1024/6e53d84fjw1emxsjasvj7j20m80m8gmw.jpg",
 verified_reason: "果壳网官方微博",
 verified_trade: "",
 verified_reason_url: "",
 verified_source: "",
 verified_source_url: "",
 verified_state: 0,
 verified_level: 3,
 verified_type_ext: 0,
 verified_reason_modified: "",
 verified_contact_name: "",
 verified_contact_email: "",
 verified_contact_mobile: "",
 follow_me: false,
 online_status: 0,
 bi_followers_count: 1730,
 lang: "zh-cn",
 star: 0,
 mbtype: 12,
 mbrank: 4,
 block_word: 0,
 block_app: 1,
 credit_score: 80,
 user_ability: 0,
 urank: 35
 },
 reposts_count: 3,
 */
@interface User : NSObject
//用户ID
@property (nonatomic, copy) NSString *idstr;
//用户昵称
@property (nonatomic, copy) NSString *name;
//用户头像
@property (nonatomic, copy) NSString *profile_image_url;
//会员等级
@property (nonatomic, assign) int mbrank;

//- (instancetype)initWithDict:(NSDictionary *)dict;
//+ (instancetype)userWithDict:(NSDictionary *)dict;
@end
