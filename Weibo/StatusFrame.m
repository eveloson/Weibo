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
    if (status.user.isVip) {
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
    _timeLabelF = (CGRect){timeLabelX,timeLabelY,timeLabelSize};
    //6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + kStatusCellLeftMargin;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:kStatusSourceFont];
    _sourceLabelF = (CGRect){sourceLabelX,sourceLabelY,sourceLabelSize};
    //7.微博正文内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = CGRectGetMaxY(_iconViewF) + 5;
    CGFloat contentLabelMaxW = topViewW - 2 * kStatusCellLeftMargin;
    CGSize contentLabelSize = [status.text sizeWithFont:kStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){contentLabelX,contentLabelY,contentLabelSize};
    //计算topView的高度
    CGFloat topViewH = CGRectGetMaxY(_contentLabelF) + kStatusCellTopMargin;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    WLog(@"topViewH=%f",topViewH);
    //计算cell的高度
    _cellHeight = topViewH;

}
@end
