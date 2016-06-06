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
#import <UIImageView+WebCache.h>
#import <MJExtension.h>

#define TitleButtonDownTag -1
#define TitleButtonUpTag 1
@interface HomeTableViewController ()
@property (nonatomic, strong) NSArray *statuses;
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置导航栏内容
    [self setupNavBar];
    
    //2. 加载微博数据
    [self setupStatusData];
    
    self.tableView.backgroundColor = [UIColor grayColor];
    
}
- (void)setupStatusData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"]     = [AccountTool account].access_token;
    params[@"count"] = @100;
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
        self.statuses = [Status objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
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
    titleButton.tag = TitleButtonDownTag;
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateFocused];
    [titleButton setTitle:@"行尸走心" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.frame = CGRectMake(0, 0, 100, 35);
    self.navigationItem.titleView = titleButton;
}

- (void)titleButtonClick:(TitleButton *)titleButton{
    if (titleButton.tag == TitleButtonUpTag) {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag = TitleButtonDownTag;
    } else {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag = TitleButtonUpTag;
    }
}

- (void)friendAttentionItemClick{
    WLog(@"friendAttention");
}

- (void)raderItemClick{
    WLog(@"raderItemClick");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    Status *status = self.statuses[indexPath.row];
    User *user = status.user;
    cell.textLabel.text = status.text;
    cell.detailTextLabel.text = user.name;
    [cell.imageView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"tabbar_profile"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Status *status = self.statuses[indexPath.row];
    return 100 ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
