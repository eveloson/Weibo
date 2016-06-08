//
//  StatusCell.h
//  Weibo
//
//  Created by BinWu on 16/6/6.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrame;
@interface StatusCell : UITableViewCell
@property (nonatomic, strong) StatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
