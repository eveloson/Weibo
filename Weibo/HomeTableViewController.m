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
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置导航栏内容
    [self setupNavBar];
    
    //2. 加载微博数据
    [self setupStatusData];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kStatusCellTopMargin, 0);
}
- (void)setupStatusData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSLog(@"%@", [AccountTool account].access_token);
    params[@"access_token"]     = [AccountTool account].access_token;
    params[@"count"] = @100;
    
    //转发～
//    NSMutableDictionary *repost = [NSMutableDictionary dictionary];
//    repost[@"access_token"] = [AccountTool account].access_token;
//    repost[@"id"] = @3984436494087209;
//    repost[@"status"] = @"autoRepost";
//    repost[@"is_comment"] = @2;
//    [mgr POST:@"https://api.weibo.com/2/statuses/repost.json" parameters:repost progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        WLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        WLog(@"%@",error);
//    }];
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //取出所有的微博数据
//        NSArray *dictArray = responseObject[@"statuses"];
//        NSMutableArray *statusArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            Status *status = [Status statusWithDict:dict];
//            [statusArray addObject:status];
//        }
//        self.statuses = statusArray;
        //2.将字典数组转换为模型数组
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
        self.statusFrames = statusFrameArray;
        
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
- (void)setupNavBar{
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendattention" highIcon:@"navigationbar_friendattention_highlighted" target:self action:@selector(friendAttentionItemClick)];
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_icon_radar"highIcon:@"navigationbar_icon_rader_highlighted" target:self action:@selector(raderItemClick)];
    //中间按钮
    TitleButton *titleButton = [TitleButton titleButton];
    NSString *titleButtonTitle = @"薛定谔的博主";
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
