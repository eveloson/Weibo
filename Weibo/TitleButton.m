//
//  TitleButton.m
//  Weibo
//
//  Created by BinWu on 16/6/4.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "TitleButton.h"
#define TitleButtonImageW 20
@implementation TitleButton

+ (instancetype)titleButton{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //高亮时不自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        //设置图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //设置文字右对其
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self setBackgroundImage:[UIImage resizableImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        [self setTitleColor:RGB(65, 65, 65) forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{

    CGFloat imageY = 0;
    CGFloat imageW = TitleButtonImageW;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = contentRect.size.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH
                      );
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleW = contentRect.size.width - TitleButtonImageW;
    CGFloat titleH = contentRect.size.height;
    
    return CGRectMake(titleX, titleY, titleW, titleH
                      );

}
@end
