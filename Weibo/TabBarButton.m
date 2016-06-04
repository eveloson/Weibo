//
//  TabBarButton.m
//  Weibo
//
//  Created by BinWu on 16/6/3.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//
//图标的比例
#define TabBarButtonImageRatio 0.6
#import "TabBarButton.h"
#import "BadgeButton.h"
@interface TabBarButton ()
// 提醒数字
@property (nonatomic, weak) BadgeButton *badgeBtn;
@end
@implementation TabBarButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:RGB(255, 119, 0)forState:UIControlStateSelected];
        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        //添加提醒数字按钮
        BadgeButton *badgeBtn = [[BadgeButton alloc] init];
   
        badgeBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeBtn];
        self.badgeBtn = badgeBtn;
        
    }
    return self;
}
- (void)setItem:(UITabBarItem *)item{
    _item = item;
    

    //KVO
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}
- (void)dealloc{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
}
/**
 *  监听到某个对象的属性改变了。就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改了
 *  @param change  属性发生的改变
 *  @param context nil
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
     
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    //设置提醒数字
    self.badgeBtn.badgeValue = self.item.badgeValue;
    //设置提醒数字的位置
    CGFloat badgeY = 2;
    CGFloat badgeX = self.frame.size.width - self.badgeBtn.frame.size.width - 10;
    CGRect badgeFrame = self.badgeBtn.frame;
    badgeFrame.origin.x = badgeX;
    badgeFrame.origin.y = badgeY;
    self.badgeBtn.frame = badgeFrame;
    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * TabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * TabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}
@end
