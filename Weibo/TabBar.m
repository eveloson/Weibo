//
//  TabBar.m
//  Weibo
//
//  Created by BinWu on 16/6/3.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "TabBar.h"
#import "TabBarButton.h"
@interface TabBar ()

@property (nonatomic, weak) TabBarButton *selectedBtn;
@property (nonatomic, weak) UIButton *plusBtn;

@property (nonatomic, strong) NSMutableArray *tabBarBtns;
@end

@implementation TabBar

- (NSMutableArray *)tabBarBtns{
    if (_tabBarBtns == nil) {
        _tabBarBtns = [NSMutableArray array];
    }
    return _tabBarBtns;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        }
        //添加一个加号按钮
        [self addPlusButtonWithImage:@"tabbar_compose_icon_add" bgImage:@"tabbar_compose_button"];
    }
    return self;
}

- (void)addPlusButtonWithImage:(NSString *)image bgImage:(NSString *)bgImage{
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [plusBtn setImage:[UIImage imageNamed:[image stringByAppendingString:@"_highlighted"]] forState:UIControlStateHighlighted];
    [plusBtn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [plusBtn setBackgroundImage:[UIImage imageNamed:[bgImage stringByAppendingString:@"_highlighted"]] forState:UIControlStateHighlighted];
    
    plusBtn.bounds = CGRectMake(0, 0, plusBtn.currentBackgroundImage.size.width, plusBtn.currentBackgroundImage.size.height);
    //添加单击事件
    [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //添加长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(plusBtnLongPress)];
    longPress.minimumPressDuration = 0.5;
    [plusBtn addGestureRecognizer:longPress];
    self.plusBtn = plusBtn;
    [self addSubview:plusBtn];

    
}

- (void)plusBtnClick{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedPlusButton)]) {
        [self.delegate tabBarDidClickedPlusButton];
    }
}

- (void)plusBtnLongPress{
    if ([self.delegate respondsToSelector:@selector(tabBarDidLongPressPlusButton)]) {
        [self.delegate tabBarDidLongPressPlusButton];
    }

}
- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    //1.创建按钮
    TabBarButton *btn = [[TabBarButton alloc] init];
    [self addSubview:btn];
    //5.添加到tabBarBtn数组
    [self.tabBarBtns addObject:btn];

    //2. 设置数据
    btn.item = item;
    
    //3.监听按钮点击
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    //4.默认点击第0个
    if (self.tabBarBtns.count == 1) {
        [self btnClick:btn]; 
    }
}

- (void)btnClick:(TabBarButton *)btn{
    //1. 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedBtn.tag to:(int)btn.tag];
    }
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //调整加号按钮的位置
    CGFloat tabH = self.frame.size.height;
    CGFloat tabW =  self.frame.size.width;
    self.plusBtn.center = CGPointMake(tabW / 2 , tabH / 2 );
    
    CGFloat btnW = tabW / self.subviews.count;
    CGFloat btnH = tabH;
    CGFloat btnY = 0;

    for (int index = 0; index < self.tabBarBtns.count; index ++) {
        //1.取出按钮
        TabBarButton *btn = self.tabBarBtns[index];
        //2.设置按钮的frame
        CGFloat btnX = index * btnW;
        if (index > 1) {
            btnX += btnW;
        }
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        //3.绑定tag
        btn.tag = index;
    }
}
@end
