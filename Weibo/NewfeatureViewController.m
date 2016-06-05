//
//  NewfeatureViewController.m
//  Weibo
//
//  Created by BinWu on 16/6/5.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "NewfeatureViewController.h"
#import "TabBarViewController.h"
#define NewfeatureImageCount 3
@interface NewfeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation NewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加UIScrollView
    
    [self setupScrollView];
    
    //2.添加pageControl
    [self setupPageControl];

    }

- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index < NewfeatureImageCount; index ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", index + 1];
        imageView.image = [UIImage imageNamed:name];
        
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        if (index == NewfeatureImageCount -1) {
            [self setupLastImageView:imageView];
        }
    }
    scrollView.contentSize = CGSizeMake(imageW * NewfeatureImageCount, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    
    [self.view addSubview:scrollView];

}
- (void)setupLastImageView:(UIImageView *)imageView{
    
    //添加开始按钮
    imageView.userInteractionEnabled = YES;
    
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    //添加checkBox
    UIButton *checkBox = [[UIButton alloc] init];
    [checkBox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkBox.bounds = startButton.bounds;
    CGFloat checkBoxCenterX = centerX;
    CGFloat checkBoxCenterY = imageView.frame.size.height * 0.5;
    checkBox.center = CGPointMake(checkBoxCenterX, checkBoxCenterY);
    [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkBox.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [checkBox addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkBox];
    
}
- (void)start{
    self.view.window.rootViewController = [[TabBarViewController alloc] init];
}
- (void)checkBoxClick:(UIButton *)checkBox{
    checkBox.selected = ! checkBox.isSelected;
}
- (void)setupPageControl{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NewfeatureImageCount;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    [self.view addSubview:pageControl];
    pageControl.userInteractionEnabled = YES;
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];
    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point"]];
    self.pageControl = pageControl;
    
}
#pragma mark delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offSetX = scrollView.contentOffset.x;
    double page = offSetX / scrollView.frame.size.width;
    self.pageControl.currentPage = (int)(page + 0.5);
    
}
@end
