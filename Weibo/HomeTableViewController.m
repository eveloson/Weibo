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
#define TitleButtonDownTag -1
#define TitleButtonUpTag 1
@interface HomeTableViewController ()

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"hjkawhelawjel";
    cell.imageView.image = [UIImage imageNamed:@"tabbar_compose_background_icon_add"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
