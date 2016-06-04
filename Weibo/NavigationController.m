//
//  NavigationController.m
//  Weibo
//
//  Created by BinWu on 16/6/4.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

/**
 *  第一次使用这个类的时候会调用（一个类只会调用一次）
 */
+ (void)initialize{
     //1.设置导航栏主题
    [self setupNavBarTheme];
    
    //2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];

}

+ (void)setupBarButtonItemTheme{
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    //设置背景
    //normal下的title
    NSMutableDictionary *textAttrNormal = [NSMutableDictionary dictionary];
    textAttrNormal[UITextAttributeFont] = [UIFont systemFontOfSize:12];
    textAttrNormal[UITextAttributeTextColor] = [UIColor grayColor];
    [barItem setTitleTextAttributes:textAttrNormal forState:UIControlStateNormal];
    //highlighted下的title
    NSMutableDictionary *textAttrHigh = [NSMutableDictionary dictionary];
    textAttrNormal[UITextAttributeFont] = [UIFont systemFontOfSize:15];
    textAttrNormal[UITextAttributeTextColor] = [UIColor orangeColor];
    [barItem setTitleTextAttributes:textAttrHigh forState:UIControlStateHighlighted];
//    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

+ (void)setupNavBarTheme{
    //取出appearence对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    //设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = RGB(82, 82, 82);
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:18];
    [navBar setTitleTextAttributes:textAttrs];
    //    [navBar setBackgroundImage:[UIImage resizableImage:@"navigationbar_background_os7"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
