//
//  TabBar.h
//  Weibo
//
//  Created by BinWu on 16/6/3.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabBar;
@protocol TabBarDelegate <NSObject>

@optional
- (void)tabBar:(TabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
- (void)tabBarDidClickedPlusButton;
- (void)tabBarDidLongPressPlusButton;
@end

@interface TabBar : UIView
@property (nonatomic, weak) id<TabBarDelegate> delegate;
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@end
