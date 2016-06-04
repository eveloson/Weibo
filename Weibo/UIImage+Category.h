//
//  UIImage+Category.h
//  a23-图片水印
//
//  Created by BinWu on 16/4/11.
//  Copyright © 2016年 BinWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
/**
 *  图片水印
 *
 *  @param bg   原图
 *  @param logo 水印图片
 *
 *  @return 新图
 */
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo;
/**
 *  图片裁剪
 *
 *  @param name        图片名
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 裁剪好的图
 */
+ (instancetype)clipCircleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  截图
 *
 *  @param view 视图
 *
 *  @return 视图的截图
 */
+ (instancetype)captureWithView:(UIView *)view;
/**
 *  返回一张可随意拉伸不变形的图片
 *
 *  @param name 原图片名
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)resizableImage:(NSString *)name;
@end
