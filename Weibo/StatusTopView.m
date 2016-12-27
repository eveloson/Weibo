//
//  StatusTopView.m
//  Weibo
//
//  Created by 吴斌 on 16/12/26.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "StatusTopView.h"
#import "ReweetStatusView.h"
#import "StatusFrame.h"
#import "User.h"
#import "Status.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"
#import "PhotosView.h"
@interface StatusTopView ()
//顶部view
@property (nonatomic, weak) UIImageView *topView;
//头像
@property (nonatomic, weak) UIImageView *iconView;
//会员图标
@property (nonatomic, weak) UIImageView *vipView;
//配图
@property (nonatomic, weak) PhotosView *photosView;
//昵称
@property (nonatomic, weak) UILabel *nameLabel;
//时间
@property (nonatomic, weak) UILabel *timeLabel;
//来源
@property (nonatomic, weak) UILabel *sourceLabel;
//正文
@property (nonatomic, weak) UILabel *contentLabel;
//被转发的微博view(父控件)
@property (nonatomic, weak) ReweetStatusView *retweetView;
@end

@implementation StatusTopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //1.设置图片
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizableImage:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizableImage:@"timeline_card_top_background_highlighted"];
        //2.头像
        UIImageView *iconView =  [[UIImageView alloc] init];
        self.iconView = iconView;
        [self addSubview:iconView];
        //3.会员图标
        UIImageView *vipView =  [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        self.vipView = vipView;
        [self addSubview:vipView];
        //4.配图
        PhotosView *photoView =  [[PhotosView alloc] init];;
        self.photosView = photoView;
        [self addSubview:photoView];
        //5.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = kStatusNameFont;
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        //6.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = kStatusTimeFont;
        timeLabel.textColor = kStatusTimeColor;
        self.timeLabel = timeLabel;
        [self addSubview:timeLabel];
        //7.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = kStatusSourceFont;
        sourceLabel.textColor = kStatusSourceColor;
        self.sourceLabel = sourceLabel;
        [self addSubview:sourceLabel];
        //8.正文
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.font = kStatusContentFont;
        contentLabel.textColor = kStatusContentColor;
        self.contentLabel = contentLabel;
        [self addSubview:contentLabel];
        //9.添加被转发的view
        ReweetStatusView *retweetView = [[ReweetStatusView alloc] init];
        self.retweetView = retweetView;
        [self addSubview:retweetView];
    }
    return self;
}

- (void)setStatusFrame:(StatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    //0.取出模型数据
    Status *status = self.statusFrame.status;
    User *user = status.user;
    //1.topView
    self.topView.frame = self.statusFrame.topViewF;
    //2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    //3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    //4.vip
    if (user.mbrank) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.nameLabel.textColor = kStatusNameVipColor;
        self.vipView.frame = self.statusFrame.vipViewF;
    } else {
        self.nameLabel.textColor = kStatusNameColor;
        self.vipView.hidden = YES;
    }
    //5.时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = self.statusFrame.timeLabelF;
    //6.来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    //7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    //8.配图
    if (status.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = self.statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;

    } else {
        self.photosView.hidden = YES;
    }
    // 9.被转发微博
    Status *retweetStatus = status.retweeted_status;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 传递模型数据
        self.retweetView.statusFrame = self.statusFrame;
    } else {
        self.retweetView.hidden = YES;
    }

}

@end
