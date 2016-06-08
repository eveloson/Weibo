//
//  StatusCell.m
//  Weibo
//
//  Created by BinWu on 16/6/6.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "StatusCell.h"
#import "Status.h"
#import "StatusFrame.h"
#import "User.h"
#import <UIImageView+WebCache.h>

@interface StatusCell ()
//顶部view
@property (nonatomic, weak) UIImageView *topView;
//头像
@property (nonatomic, weak) UIImageView *iconView;
//会员图标
@property (nonatomic, weak) UIImageView *vipView;
//配图
@property (nonatomic, weak) UIImageView *photoView;
//昵称
@property (nonatomic, weak) UILabel *nameLabel;

//时间
@property (nonatomic, weak) UILabel *timeLabel;

//来源
@property (nonatomic, weak) UILabel *sourceLabel;

//正文
@property (nonatomic, weak) UILabel *contentLabel;

//被转发的微博view(父控件)
@property (nonatomic, weak) UIImageView *retweetView;
//被转发正文
@property (nonatomic, weak) UILabel *retweetContentLabel;
//被转发作者昵称
@property (nonatomic, weak) UILabel *retweetNameLabel;
//被转发微博配图
@property (nonatomic, weak) UIImageView *retweetPhotoView;
//微博工具条
@property (nonatomic, weak) UIImageView *statusToolbar;

@end
@implementation StatusCell
static NSString *ID = @"cell";

+ (instancetype)cellWithTableView:(UITableView *)tableView{

    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        //2.添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        //3.添加微博的工具条
        [self setupStatusToolBar];
    }
    
    return self;
}
/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews{
    //1. 顶部的view
    UIImageView *topView = [[UIImageView alloc] init];
    self.topView = topView;
    [self.contentView addSubview:topView];
    //2.头像
    UIImageView *iconView =  [[UIImageView alloc] init];
    self.iconView = iconView;
    [self.topView addSubview:iconView];
    //3.会员图标
    UIImageView *vipView =  [[UIImageView alloc] init];
    self.vipView = vipView;
    [self.topView addSubview:vipView];
    //4.配图
    UIImageView *photoView =  [[UIImageView alloc] init];;
    self.photoView = photoView;
    [self.topView addSubview:photoView];
    //5.昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = kStatusNameFont;
    self.nameLabel = nameLabel;
    [self.topView addSubview:nameLabel];
    //6.时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = kStatusTimeFont;
    self.timeLabel = timeLabel;
    [self.topView addSubview:timeLabel];
    //7.来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = kStatusSourceFont;
    self.sourceLabel = sourceLabel;
    [self.topView addSubview:sourceLabel];
    //8.正文
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = kStatusContentFont;
    self.contentLabel = contentLabel;
    [self.topView addSubview:contentLabel];
}
/**
 *  添加被转发微博内部的子控件
 */
- (void)setupRetweetSubviews{
    //1.被转发的微博view(父控件)
    UIImageView *retweetView = [[UIImageView alloc] init];
    [self.topView addSubview:retweetView];
    //2.被转发正文
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    self.retweetContentLabel = retweetContentLabel;
    [self.retweetView addSubview:retweetContentLabel];
    //3.被转发作者昵称
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    self.retweetNameLabel = retweetNameLabel;
    [self.retweetView addSubview:retweetNameLabel];
    //4.被转发微博配图
    UIImageView *retweetPhotoView =  [[UIImageView alloc] init];;
    self.retweetPhotoView = retweetPhotoView;
    [self.retweetView addSubview:retweetPhotoView];

}
/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar{
    UIImageView *statusToolbar =  [[UIImageView alloc] init];;
    self.statusToolbar = statusToolbar;
    [self.retweetView addSubview:statusToolbar];
}
/**
 *  传递模型数据
 */
- (void)setStatusFrame:(StatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    //1.原创微博
    [self setupOriginalData];
}
- (void)setupOriginalData{
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
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:@"common_icon_membership"];
        self.vipView.frame = self.statusFrame.vipViewF;
    } else {
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
    
}
/**
 *  转发微博数据
 */
@end
