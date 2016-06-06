//
//  StatusCell.m
//  Weibo
//
//  Created by BinWu on 16/6/6.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "StatusCell.h"
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
    self.nameLabel = nameLabel;
    [self.topView addSubview:nameLabel];
    //6.时间
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    [self.topView addSubview:timeLabel];
    //7.来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    self.sourceLabel = sourceLabel;
    [self.topView addSubview:sourceLabel];
    //8.正文
    UILabel *contentLabel = [[UILabel alloc] init];
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
