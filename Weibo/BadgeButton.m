//
//  BadgeButton.m
//  Weibo
//
//  Created by BinWu on 16/6/3.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "BadgeButton.h"

@implementation BadgeButton


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.hidden = YES;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setBackgroundImage:[UIImage resizableImage:@"main_badge"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
#warning copy
    _badgeValue = [badgeValue copy];
    if (badgeValue) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        //设置自己的宽高
        CGRect frame = self.frame;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        if (badgeValue.length > 1) {
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
