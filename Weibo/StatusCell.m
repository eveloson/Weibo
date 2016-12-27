//
//  StatusCell.m
//  Weibo
//
//  Created by BinWu on 16/6/6.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "StatusCell.h"
#import "Status.h"
#import "StatusFrame.h"
#import "User.h"
#import "StatusToolbar.h"
#import <UIImageView+WebCache.h>
#import "StatusTopView.h"
@interface StatusCell ()
/** 顶部的view */
@property (nonatomic, weak) StatusTopView *topView;

//微博工具条
@property (nonatomic, weak) StatusToolbar *statusToolbar;

@end
@implementation StatusCell
static NSString *ID = @"cell";

+ (instancetype)cellWithTableView:(UITableView *)tableView{

    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.添加顶部的view
        [self setupTopView];
        //2.添加微博的工具条
        [self setupStatusToolBar];

    }
    
    return self;
}
/**
 *  拦截frame的设置
 *
 *  @param frame <#frame description#>
 */
- (void)setFrame:(CGRect)frame{
    frame.origin.y += kStatusCellTopMargin;
    frame.size.height -= kStatusCellTopMargin + 2;
    [super setFrame:frame];
}
/**
 *  添加顶部的view
 */
- (void)setupTopView{
    // 0.设置cell选中时的背景
    self.selectedBackgroundView = [[UIView alloc] init];
    self.backgroundColor = [UIColor clearColor];
    // 1.顶部view
    StatusTopView *topView = [[StatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar{
    StatusToolbar *statusToolbar =  [[StatusToolbar alloc] init];
//    statusToolbar.backgroundColor = [UIColor redColor];
    self.statusToolbar = statusToolbar;
    [self.contentView addSubview:statusToolbar];
}
/**
 *  传递模型数据
 */
- (void)setStatusFrame:(StatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    //1.顶部view
    [self setupTopViewData];
    //2.微博工具条
    [self setupStatusToolBarData];

}
- (void)setupTopViewData{
    self.topView.frame = self.statusFrame.topViewF;
    self.topView.statusFrame = self.statusFrame;
}
/**
 *  工具条数据
 */
- (void)setupStatusToolBarData{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
    self.statusToolbar.status = self.statusFrame.status;
}
@end
