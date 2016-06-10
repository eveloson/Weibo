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
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    //2.头像
    CGFloat iconViewWH = 42;
    CGFloat iconViewX = kStatusCellLeftMargin;
    CGFloat iconViewY = kStatusCellTopMargin;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    //3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + kStatusCellLeftMargin;
    CGFloat nameLabelY = iconViewY + 3;
    CGSize nameLabelSize = [status.user.name sizeWithFont:kStatusNameFont];
    _nameLabelF = (CGRect){nameLabelX,nameLabelY,nameLabelSize};
    //4.会员图标
    if (status.user.mbrank) {
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
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    //8.配图
    if (status.thumbnail_pic) {
        CGFloat photoViewWH = 100;
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + kStatusCellLeftMargin;
        _photoViewF = CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH);
    }
    //9.被转发微博
    if (status.retweeted_status) {
        CGFloat retweetViewW = topViewW;
        CGFloat retweetViewH = kStatusCellTopMargin;
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + kStatusCellTopMargin;
        //10.被转发微博作者昵称
        CGFloat retweetNameLabelX = kStatusCellLeftMargin;
        CGFloat retweetNameLabelY = kStatusCellTopMargin;
        NSString *name = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
        CGSize  retweetNameLabelSize = [name sizeWithFont:kRetweetStatusNameFont];
        _retweetNameLabelF = (CGRect){retweetNameLabelX,retweetNameLabelY,retweetNameLabelSize};
        //11.被转发微博的正文
        CGFloat retweetContentLabelX = kStatusCellLeftMargin;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + kStatusCellTopMargin;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * kStatusCellLeftMargin;
        CGSize  retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:kRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){retweetContentLabelX,retweetContentLabelY,retweetContentLabelSize};
        //12.被转发微博的配图
        if (status.retweeted_status.thumbnail_pic) {
            CGFloat retweetPhotoViewWH = 50;
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) + kStatusCellTopMargin;
            _retweetPhotoViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewWH, retweetPhotoViewWH);
            retweetViewH += CGRectGetMaxY(_retweetPhotoViewF);
        } else {
            retweetViewH += CGRectGetMaxY(_retweetContentLabelF);

        }
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        topViewH = CGRectGetMaxY(_retweetViewF);
        
    } else { //没有转发微博
        if (status.thumbnail_pic) {
            topViewH = CGRectGetMaxY(_photoViewF);

        } else {
            topViewH = CGRectGetMaxY(_contentLabelF);

        }
        //topView上下间距
        topViewH += 2 * kStatusCellTopMargin;
        
    }
    
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    //13.工具条的frame
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolbarH = 35;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    //14.cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + kStatusCellTopMargin;


}
@end
