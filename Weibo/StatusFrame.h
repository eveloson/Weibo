//
//  StatusFrame.h
//  Weibo
//
//  Created by BinWu on 16/6/6.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//  一个cell对应一个StatusFrame对象

#import <Foundation/Foundation.h>
//昵称字体
#define kStatusNameFont [UIFont systemFontOfSize:15]
//时间字体
#define kStatusTimeFont [UIFont systemFontOfSize:11]

//来源字体
#define kStatusSourceFont kStatusTimeFont

//正文字体
#define kStatusContentFont [UIFont systemFontOfSize:15]

@class Status;
@interface StatusFrame : NSObject
@property (nonatomic, strong) Status *status;
//顶部view
@property (nonatomic, assign, readonly) CGRect topViewF;
//头像
@property (nonatomic, assign, readonly) CGRect iconViewF;
//会员图标
@property (nonatomic, assign, readonly) CGRect vipViewF;
//配图
@property (nonatomic, assign, readonly) CGRect photoViewF;
//昵称
@property (nonatomic, assign, readonly) CGRect nameLabelF;

//时间
@property (nonatomic, assign, readonly) CGRect timeLabelF;

//来源
@property (nonatomic, assign, readonly) CGRect sourceLabelF;

//正文
@property (nonatomic, assign, readonly) CGRect contentLabelF;

//被转发的微博view(父控件)
@property (nonatomic, assign, readonly) CGRect retweetViewF;
//被转发正文
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
//被转发作者昵称
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
//被转发微博配图
@property (nonatomic, assign, readonly) CGRect retweetPhotoViewF;
//微博工具条
@property (nonatomic, assign, readonly) CGRect statusToolbarF;
//cell的高度
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
