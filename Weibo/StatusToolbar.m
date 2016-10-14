//
//  StatusToolbar.m
//  Weibo
//
//  Created by BinWu on 16/6/10.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "StatusToolbar.h"

@interface StatusToolbar ()
@property(nonatomic, strong) NSMutableArray* btns;
@property(nonatomic, strong) NSMutableArray* dividers;
@end

@implementation StatusToolbar

- (NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (NSMutableArray *)dividers{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //0.设置用户交互
        self.userInteractionEnabled = YES;
        //1.设置图片
        self.image = [UIImage resizableImage:@"timeline_card_bottom_background"];
        //        self.highlightedImage = [UIImage resizableImage:@"timeline_card_bottom_background_highlighted"];
        //2.添加按钮
        [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet_disable" bgImage:@"timeline_card_bottom_background_highlighted"];
        [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment_disable" bgImage:@"timeline_card_bottom_background_highlighted"];
        [self setupBtnWithTitle:@"赞" image:@"timeline_icon_like_disable" bgImage:@"timeline_card_bottom_background_highlighted"];
        //3.添加两条分割线
        [self setupDivider];
        [self setupDivider];
        
    }
    return self;
}
/**
 *  初始化分割线
 */
- (void)setupDivider{
    UIImageView *divider = [[UIImageView alloc] init];
    [divider setImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
    [divider setHighlightedImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"]];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

- (void)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //图片不随背景改变
    btn.adjustsImageWhenHighlighted = NO;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setBackgroundImage:[UIImage resizableImage:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    [self.btns addObject:btn];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //1.设置按钮的frame
    int btnCount = (int)self.btns.count;
    CGFloat btnW = self.frame.size.width / btnCount;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.btns[i];
        //设置frame
        CGFloat btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }
    //2.设置分割线的frame
    CGFloat dividerH = btnH;
    CGFloat dividerW = 1;
    CGFloat dividerY = 0;
    int dividerCount = (int)self.dividers.count;
    for (int j = 0; j < dividerCount; j++) {
        UIImageView *divider = self.dividers[j];
        //设置frame
        CGFloat dividerX = (j + 1) * btnW;
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}
@end
