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
#define kStatusNameColor RGB(38, 38, 38)
#define kStatusNameVipColor RGB(229, 74, 36);
#define kStatusTimeColor  RGB(129, 129, 129)
#define kStatusSourceColor kStatusTimeColor
#define kStatusContentColor RGB(38,38,38)
#define kRetweetContentColor RGB(80,80,80)
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
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
 *  拦截frame的设置
 *
 *  @param frame <#frame description#>
 */
- (void)setFrame:(CGRect)frame{
    frame.origin.y += kStatusCellTopMargin;
    frame.size.height -= kStatusCellTopMargin + 2;
    [super setFrame:frame];
}
/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews{
    //0.设置cell的选中时背景
//    self.selectedBackgroundView = 
    //1. 顶部的view
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage resizableImage:@"timeline_card_top_background"];
    topView.highlightedImage = [UIImage resizableImage:@"timeline_card_top_background_highlighted"];
    self.topView = topView;
    [self.contentView addSubview:topView];
    //2.头像
    UIImageView *iconView =  [[UIImageView alloc] init];
    self.iconView = iconView;
    [self.topView addSubview:iconView];
    //3.会员图标
    UIImageView *vipView =  [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
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
    timeLabel.textColor = kStatusTimeColor;
    self.timeLabel = timeLabel;
    [self.topView addSubview:timeLabel];
    //7.来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = kStatusSourceFont;
    sourceLabel.textColor = kStatusSourceColor;
    self.sourceLabel = sourceLabel;
    [self.topView addSubview:sourceLabel];
    //8.正文
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = kStatusContentFont;
    contentLabel.textColor = kStatusContentColor;
    self.contentLabel = contentLabel;
    [self.topView addSubview:contentLabel];
}
/**
 *  添加被转发微博内部的子控件
 */
- (void)setupRetweetSubviews{
    //1.被转发的微博view(父控件)
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage resizableImage:@"timeline_retweet_background"];
    retweetView.highlightedImage = [UIImage resizableImage:@"timeline_retweet_background_highlighted"];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    //2.被转发正文
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = kRetweetStatusContentFont;
    retweetContentLabel.numberOfLines = 0;
    self.retweetContentLabel = retweetContentLabel;
    [self.retweetView addSubview:retweetContentLabel];
    //3.被转发作者昵称
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.font = kRetweetStatusNameFont;
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
    UIImageView *statusToolbar =  [[UIImageView alloc] init];
//    statusToolbar.backgroundColor = [UIColor redColor];
    statusToolbar.image = [UIImage resizableImage:@"timeline_card_bottom_background"];
    statusToolbar.highlightedImage = [UIImage resizableImage:@"timeline_card_bottom_background_highlighted"];
    self.statusToolbar = statusToolbar;
    [self.contentView addSubview:statusToolbar];
}
/**
 *  传递模型数据
 */
- (void)setStatusFrame:(StatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    //1.原创微博
    [self setupOriginalData];
    //2.转发微博
    [self setupRetweetData];
    //3.微博工具条
    [self setupStatusToolBarData];

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
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    } else {
        self.photoView.hidden = YES;
    }
}
/**
 *  转发微博数据
 */
- (void)setupRetweetData{
    Status *retweetStatus = self.statusFrame.status.retweeted_status;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        User *user = retweetStatus.user;
        //1.父控件
        self.retweetView.frame = self.statusFrame.retweetViewF;
        //2.昵称
        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        //3.正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        //4.配图
        if (retweetStatus.thumbnail_pic) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        } else {
            self.retweetPhotoView.hidden = YES;
        }

    } else {
        self.retweetView.hidden = YES;
    }
    
}
/**
 *  工具条数据
 */
- (void)setupStatusToolBarData{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
}
@end
