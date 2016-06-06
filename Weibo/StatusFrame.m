//
//  StatusFrame.m
//  Weibo
//
//  Created by BinWu on 16/6/6.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
//cell 边框宽度
#define kStatusCellTopMargin 5
#define kStatusCellLeftMargin 5
//昵称字体
#define kStatusNameFont [UIFont systemFontOfSize:15]
//时间字体
#define kStatusTimeFont [UIFont systemFontOfSize:11]

//来源字体
#define kStatusSourceFont kStatusTimeFont

@implementation StatusFrame
/**
 *  获得微博模型数据后，根据微博数据计算frame
 */
- (void)setStatus:(Status *)status{
    _status = status;
    //cell的宽度
    CGFloat cellW = kWidth;
    //1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    //2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = kStatusCellLeftMargin;
    CGFloat iconViewY = kStatusCellTopMargin;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    //3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + kStatusCellLeftMargin;
    CGFloat nameLabelY = iconViewY + 3;
    CGSize nameLabelSize = [status.user.name sizeWithFont:kStatusNameFont];
    _nameLabelF = (CGRect){nameLabelX,nameLabelY,nameLabelSize};
    //4.会员图标
    if (status.user.vip) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + 2;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    //5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + 3;
    CGSize timeLabelSize = [status.created_at sizeWithFont:kStatusTimeFont];
    _nameLabelF = (CGRect){timeLabelX,timeLabelY,timeLabelSize};
    //6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + kStatusCellLeftMargin;
    CGFloat sourceLabelY = CGRectGetMaxY(_nameLabelF) + 3;
    CGSize sourceLabelSize = [status.created_at sizeWithFont:kStatusSourceFont];
    _nameLabelF = (CGRect){timeLabelX,timeLabelY,timeLabelSize};
    

}
@end
