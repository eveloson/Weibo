//
//  Status.h
//  Weibo
//
//  Created by BinWu on 16/6/6.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 {
 created_at: "Mon Jun 06 15:13:36 +0800 2016",
 id: 3983388194719552,
 mid: "3983388194719552",
 idstr: "3983388194719552",
 text: "【就要高考了，考听力时打雷了怎么办？】有啥办法，做好心理准备呗。据@中国天气 的数据，在6月8日下午考听力那半小时内，刚好遇上打雷的概率其实相当的低。这里是历年来高考期间恶劣天气的统计，哪些地区有可能遇上高温、大雨？来看看，心里有个地儿→_→http://t.cn/R5tuwq7",
 textLength: 256,
 source_allowclick: 0,
 source_type: 1,
 source: "<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>",
 favorited: false,
 truncated: false,
 in_reply_to_status_id: "",
 in_reply_to_user_id: "",
 in_reply_to_screen_name: "",
 pic_urls: [
 {
 thumbnail_pic: "http://ww3.sinaimg.cn/thumbnail/6e53d84fgw1f4liwgjgzij20go0cojt5.jpg"
 },
 {
 thumbnail_pic: "http://ww4.sinaimg.cn/thumbnail/6e53d84fgw1f4liwh4k8sj20go0g33zy.jpg"
 },
 {
 thumbnail_pic: "http://ww4.sinaimg.cn/thumbnail/6e53d84fgw1f4liwhsm8pj20go0dddhb.jpg"
 },
 {
 thumbnail_pic: "http://ww3.sinaimg.cn/thumbnail/6e53d84fgw1f4liwib9m9j20go0ddgmz.jpg"
 }
 ],
 thumbnail_pic: "http://ww3.sinaimg.cn/thumbnail/6e53d84fgw1f4liwgjgzij20go0cojt5.jpg",
 bmiddle_pic: "http://ww3.sinaimg.cn/bmiddle/6e53d84fgw1f4liwgjgzij20go0cojt5.jpg",
 original_pic: "http://ww3.sinaimg.cn/large/6e53d84fgw1f4liwgjgzij20go0cojt5.jpg",
 geo: null,
 user: {},
 reposts_count: 3,
 comments_count: 9,
 attitudes_count: 5,
 isLongText: false,
 mlevel: 0,
 visible: {
 type: 0,
 list_id: 0
 },
 biz_feature: 0,
 darwin_tags: [ ],
 hot_weibo_tags: [ ],
 text_tag_tips: [ ],
 rid: "0_0_1_2666868915024693099",
 userType: 0
 },

 */
@class User;
@interface Status : NSObject
//内容
@property (nonatomic, copy) NSString *text;
//来源
@property (nonatomic, copy) NSString *source;
//微博时间
@property (nonatomic, copy) NSString *created_at;
//private key
@property (nonatomic, copy) NSString *idstr;
//转发数
@property (nonatomic, assign) int reposts_count;
//评论数
@property (nonatomic, assign) int comments_count;
//点赞数
@property (nonatomic, assign) int attitudes_count;
//用户
@property (nonatomic, strong) User *user;
/**
 *  微博的配图(数组中装模型:IWPhoto)
 */
@property (nonatomic, strong) NSArray *pic_urls;
////单张配图（小）
//@property (nonatomic, copy) NSString *thumbnail_pic;

//被转发的微博
@property (nonatomic, strong) Status *retweeted_status;
//- (instancetype)initWithDict:(NSDictionary *)dict;
//+ (instancetype)statusWithDict:(NSDictionary *)dict;
@end
