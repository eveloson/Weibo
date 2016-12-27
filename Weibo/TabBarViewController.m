//
//  TabBarViewController.m
//  Weibo
//
//  Created by BinWu on 16/6/3.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "TabBarViewController.h"
#import "MeTableViewController.h"
#import "MessageTableViewController.h"
#import "DiscoverTableViewController.h"
#import "HomeTableViewController.h"
#import "TabBar.h"
#import "NavigationController.h"
@interface TabBarViewController () <TabBarDelegate>
@property (nonatomic, weak) TabBar *tab;
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化自定义tabBar
    [self setupTabBar];
    //初始化所有的子控制器
    [self setupAllChildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
- (void)setupTabBar{
    TabBar *tab = [[TabBar alloc] init];
    tab.frame = self.tabBar.bounds;
    tab.delegate = self;
    [self.tabBar addSubview:tab];
    self.tab = tab;
}

- (void)setupAllChildViewControllers{
    //1. 首页
    HomeTableViewController *home = [[HomeTableViewController alloc] init];
    home.tabBarItem.badgeValue = @"10";
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    
    //2. 消息
    MessageTableViewController *message = [[MessageTableViewController alloc] init];
    message.tabBarItem.badgeValue = @"99+";
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    
    //3. 发现
    DiscoverTableViewController *discover = [[DiscoverTableViewController alloc] init];
    discover.tabBarItem.badgeValue = @"1";
    [self setupChildViewController:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    
    //4. 我
    MeTableViewController *me = [[MeTableViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}
/**
 *  初始化一个子控制器
 *
 *  @param childVC           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    //1.设置控制器的属性
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //2.包装一个导航控制器
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
    //3. 添加tabBar内部的按钮
    [self.tab addTabBarButtonWithItem:childVC.tabBarItem];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tabbar Delegate
/**
 *  监听tabbar的按钮改变事件
 */
- (void)tabBar:(TabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to{
    self.selectedIndex = to;
}

- (void)tabBarDidClickedPlusButton{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor blueColor];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)tabBarDidLongPressPlusButton{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor yellowColor];
    [self presentViewController:vc animated:YES completion:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
