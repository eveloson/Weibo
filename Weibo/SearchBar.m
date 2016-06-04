//
//  SearchBar.m
//  Weibo
//
//  Created by BinWu on 16/6/4.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "SearchBar.h"
@implementation SearchBar

+ (instancetype)searchBar{
    return [[self alloc] init];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.background = [UIImage resizableImage:@"navigationbar_searchbar_background"];
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationbar_searchbar_search"]];
        leftView.contentMode = UIViewContentModeCenter;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        //    searchBar.placeholder = @"大家正在搜：xxxxxx";
        self.font = [UIFont systemFontOfSize:13];
        
        self.clearButtonMode = UITextFieldViewModeAlways;
//        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"大家正在搜：XXXX" attributes:attrs];
        //设置键盘右下角按钮的样式
        self.returnKeyType = UIReturnKeySearch;
        //设置自动是否能用
        self.enablesReturnKeyAutomatically = YES;

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //设置左边图标的frame
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
}
@end
