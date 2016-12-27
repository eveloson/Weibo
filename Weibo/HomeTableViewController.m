//
//  HomeTableViewController.m
//  Weibo
//
//  Created by BinWu on 16/6/3.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "HomeTableViewController.h"
#import "UIBarButtonItem+Category.h"
#import "TitleButton.h"
#import "Account.h"
#import "AccountTool.h"
#import "Status.h"
#import "User.h"
#import "StatusFrame.h"
#import "StatusCell.h"
#import <UIImageView+WebCache.h>
#import <MJExtension.h>

#define kTitleButtonDownTag -1
#define kTitleButtonUpTag 1
#define kTitleButtonFont [UIFont systemFontOfSize:17]
@interface HomeTableViewController () <UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *statusFrames;
@property(nonatomic, weak) TitleButton* titleButton;
@end

@implementation HomeTableViewController
- (NSMutableArray *)statusFrames{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //0.集成刷新控件
    [self setupRefreshView];
    //1.设置导航栏内容
    [self setupNavBar];

    //2. 获取用户信息
    [self setupUserData];
    //取消cell之间的分割线
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kStatusCellTopMargin, 0);
}

/**
 集成刷新控件
 */
- (void)setupRefreshView{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    //自动进入刷新状态
    [refreshControl beginRefreshing];
    //直接加载数据
    [self refreshControlStateChange:refreshControl];
}

/**
 手动进入刷新状态调用

 @param refreshControl <#refreshControl description#>
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"]     = [AccountTool account].access_token;
    params[@"count"] = @50;
    if(self.statusFrames.count){
        StatusFrame *statusFrame = self.statusFrames[0];
        params[@"since_id"] = statusFrame.status.idstr;
    }
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *statusArray = [Status mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        WLog(@"%@",responseObject[@"statuses"]);
        //创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (Status *status in statusArray) {
            StatusFrame *statusFrame = [[StatusFrame alloc] init];
            //传递模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        //将新数据插入到修数据前面
        [self.statusFrames insertObjects:statusFrameArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statusFrameArray.count)]];
        //刷新表格
        [self.tableView reloadData];
        [refreshControl endRefreshing];
        //显示最新微博的数量
        [self showNewStatusCount:statusFrameArray.count];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [refreshControl endRefreshing];
    }];
}

- (void)showNewStatusCount:(NSUInteger)count{
    //1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    //2.设置图片和文字
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizableImage:@"timeline_new_status_background"] forState:UIControlStateNormal];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"更新了%lu条微博", (unsigned long)count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新微博" forState:UIControlStateNormal];
    }
    //3.设置按钮的初始frame
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnW = self.view.frame.size.width;
    CGFloat btnX = 0;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    //4.动画
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH);
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
           //恢复原来
           btn.transform = CGAffineTransformIdentity;
       } completion:^(BOOL finished) {
           [btn removeFromSuperview];
       }];
    }];
}
- (void)setupNavBar{
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendattention" highIcon:@"navigationbar_friendattention_highlighted" target:self action:@selector(friendAttentionItemClick)];
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_icon_radar"highIcon:@"navigationbar_icon_rader_highlighted" target:self action:@selector(raderItemClick)];
    //中间按钮
    TitleButton *titleButton = [TitleButton titleButton];
    NSString *titleButtonTitle = @"首页";
    titleButton.tag = kTitleButtonDownTag;
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateFocused];
    [titleButton setTitle:titleButtonTitle forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    CGSize titleButtonSize = [titleButtonTitle sizeWithFont:kTitleButtonFont];
    titleButtonSize.width += kTitleButtonImageW + 15;
    titleButtonSize.height += 15;
    titleButton.frame = (CGRect){0,0,titleButtonSize};
    self.navigationItem.titleView = titleButton;
    //tableview背景
    self.tableView.backgroundColor = RGB(239, 239, 239);
    self.titleButton = titleButton;
}

- (void)setupUserData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"]     = [AccountTool account].access_token;
    params[@"uid"]     = @([AccountTool account].uid);

    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        User *user = [User mj_objectWithKeyValues:responseObject];
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

}
- (void)titleButtonClick:(TitleButton *)titleButton{
    if (titleButton.tag == kTitleButtonUpTag) {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag = kTitleButtonDownTag;
    } else {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag = kTitleButtonUpTag;
    }
}

- (void)friendAttentionItemClick{
    WLog(@"friendAttention");
}

- (void)raderItemClick{
    WLog(@"raderItemClick");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusCell *cell = [StatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
