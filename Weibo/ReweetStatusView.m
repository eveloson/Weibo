//
//  ReweetStatusView.m
//  Weibo
//
//  Created by 吴斌 on 16/12/26.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "ReweetStatusView.h"
#import "Status.h"
#import "PhotosView.h"
#import "UIImage+Category.h"
#import "StatusFrame.h"
#import "User.h"
#import "Photo.h"
#import "UIImageView+WebCache.h"
@interface ReweetStatusView ()
/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *reweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *reweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) PhotosView *reweetPhotosView;

@end

@implementation ReweetStatusView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置图片
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        self.highlightedImage = [UIImage resizableImage:@"timeline_retweet_background_highlighted"];
        /** 2.被转发微博作者的昵称 */
        UILabel *reweetNameLabel = [[UILabel alloc] init];
        reweetNameLabel.font = kRetweetStatusNameFont;
        reweetNameLabel.textColor = RGB(67, 107, 163);
        reweetNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:reweetNameLabel];
        self.reweetNameLabel = reweetNameLabel;
        
        /** 3.被转发微博的正文\内容 */
        UILabel *reweetContentLabel = [[UILabel alloc] init];
        reweetContentLabel.font = kRetweetStatusContentFont;
        reweetContentLabel.backgroundColor = [UIColor clearColor];
        reweetContentLabel.numberOfLines = 0;
        reweetContentLabel.textColor = RGB(90, 90, 90);
        [self addSubview:reweetContentLabel];
        self.reweetContentLabel = reweetContentLabel;
        
        /** 4.被转发微博的配图 */
        PhotosView *retweetPhotoView = [[PhotosView alloc] init];
        [self addSubview:retweetPhotoView];
        self.reweetPhotosView = retweetPhotoView;
    }
    return self;
}

- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    Status *reweetStatus = statusFrame.status.retweeted_status;
    User *user = reweetStatus.user;
    
    // 1.昵称
    self.reweetNameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
    self.reweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
    
    // 2.正文
    self.reweetContentLabel.text = reweetStatus.text;
    self.reweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
    
    // 3.配图
    if (reweetStatus.pic_urls.count) {
        self.reweetPhotosView.hidden = NO;
        self.reweetPhotosView.frame = self.statusFrame.retweetPhotoViewF;
        self.reweetPhotosView.photos = reweetStatus.pic_urls;
    } else {
        self.reweetPhotosView.hidden = YES;
    }
}

@end
