//
//  StatusToolbar.m
//  Weibo
//
//  Created by BinWu on 16/6/10.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "StatusToolbar.h"
#import "Status.h"
@interface StatusToolbar ()
@property(nonatomic, strong) NSMutableArray* btns;
@property(nonatomic, strong) NSMutableArray* dividers;
@property (nonatomic, weak) UIButton *reweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;
@end

@implementation StatusToolbar

- (NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (NSMutableArray *)dividers{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //0.设置用户交互
        self.userInteractionEnabled = YES;
        //1.设置图片
        self.image = [UIImage resizableImage:@"timeline_card_bottom_background"];
        //        self.highlightedImage = [UIImage resizableImage:@"timeline_card_bottom_background_highlighted"];
        //2.添加按钮
        self.reweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet_disable" bgImage:@"timeline_card_bottom_background_highlighted"];
        self.commentBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment_disable" bgImage:@"timeline_card_bottom_background_highlighted"];
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_like_disable" bgImage:@"timeline_card_bottom_background_highlighted"];
        //3.添加两条分割线
        [self setupDivider];
        [self setupDivider];
        
    }
    return self;
}
/**
 *  初始化分割线
 */
- (void)setupDivider{
    UIImageView *divider = [[UIImageView alloc] init];
    [divider setImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
    [divider setHighlightedImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"]];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}
/**
 *  初始化按钮
 *
 *  @param title   按钮的文字
 *  @param image   按钮的小图片
 *  @param bgImage 按钮的背景
 */
- (UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //图片不随背景改变
    btn.adjustsImageWhenHighlighted = NO;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setBackgroundImage:[UIImage resizableImage:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //1.设置按钮的frame
    int btnCount = (int)self.btns.count;
    CGFloat btnW = self.frame.size.width / btnCount;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.btns[i];
        //设置frame
        CGFloat btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }
    //2.设置分割线的frame
    CGFloat dividerH = btnH;
    CGFloat dividerW = 1;
    CGFloat dividerY = 0;
    int dividerCount = (int)self.dividers.count;
    for (int j = 0; j < dividerCount; j++) {
        UIImageView *divider = self.dividers[j];
        //设置frame
        CGFloat dividerX = (j + 1) * btnW;
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}

- (void)setStatus:(Status *)status{
    _status = status;
    
    // 1.设置转发数
    [self setupBtn:self.reweetBtn originalTitle:@"转发" count:status.reposts_count];
    [self setupBtn:self.commentBtn originalTitle:@"评论" count:status.comments_count];
    [self setupBtn:self.attitudeBtn originalTitle:@"赞" count:status.attitudes_count];
}
/**
 *  设置按钮的显示标题
 *
 *  @param btn           哪个按钮需要设置标题
 *  @param originalTitle 按钮的原始标题(显示的数字为0的时候, 显示这个原始标题)
 *  @param count         显示的个数
 */
- (void)setupBtn:(UIButton *)btn originalTitle:(NSString *)originalTitle count:(int)count
{
    /**
     0 -> @"转发"
     <10000  -> 完整的数量, 比如个数为6545,  显示出来就是6545
     >= 10000
     * 整万(10100, 20326, 30000 ....) : 1万, 2万
     * 其他(14364) : 1.4万
     */
    
    if (count) { // 个数不为0
        NSString *title = nil;
        if (count < 10000) { // 小于1W
            title = [NSString stringWithFormat:@"%d", count];
        } else { // >= 1W
            // 42342 / 1000 * 0.1 = 42 * 0.1 = 4.2
            // 10742 / 1000 * 0.1 = 10 * 0.1 = 1.0
            // double countDouble = count / 1000 * 0.1;
            
            // 42342 / 10000.0 = 4.2342
            // 10742 / 10000.0 = 1.0742
            double countDouble = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", countDouble];
            
            // title == 4.2万 4.0万 1.0万 1.1万
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }

}
@end
