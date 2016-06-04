//
//  UIImage+Category.m
//  a23-图片水印
//
//  Created by BinWu on 16/4/11.
//  Copyright © 2016年 BinWu. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo{
    UIImage *bgImage = [UIImage imageNamed:bg];
    // Do any additional setup after loading the view, typically from a nib.
    //上下文：基于位图（bitmap），所有东西需要绘制到一张信的图片上
    //1.创建一个基于位图的上下文
    //size:新图片的尺寸
    //opaque:YES 不透明 NO：透明
    //这行代码过后，就相当于创建一张新的bitmap，也就是新的UIImage对象
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    //2.背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    //3.画右下角的水印
    UIImage *waterImage = [UIImage imageNamed:logo];
    CGFloat scale = 0.5;
    CGFloat margin = 5;
    CGFloat waterW = waterImage.size.width *scale;
    CGFloat waterH = waterImage.size.height * scale;
    CGFloat waterX = bgImage.size.width - waterW - margin;
    CGFloat waterY = bgImage.size.height - waterH - margin;
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    //4.从上下文中取得制作完毕的UIImage对象
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.结束上下文
    UIGraphicsEndImageContext();
    return newImage;
//    //6.显示到UIImageVIew
//    self.iconView.image = newImage;
//    //7.保存图片，将image对象压缩为png格式的二进制数据
//    NSData *data = UIImageJPEGRepresentation(newImage, 1.0);
//    //8.写入文件
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"new.jpg"];
//    [data writeToFile:path atomically:YES];

}
//+ (instancetype)clipImageWithCircle:(NSString *)image{
//    //1.加载原图
//    UIImage *oldImage = [UIImage imageNamed:image];
//    //2.开启上下文
//    UIGraphicsBeginImageContextWithOptions(oldImage.size, NO, 0.0);
//    //3.取得当前的上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    //4.画圆
//    CGRect circleRect = CGRectMake(0, 0, oldImage.size.width, oldImage.size.height);
//    CGContextAddEllipseInRect(ctx, circleRect);
//    //5.按照当前的路径形状（圆）裁剪
//    CGContextClip(ctx);
//    //6.画圆
//    [oldImage drawInRect:circleRect];
//    //7.取图
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    //8.结束
//    UIGraphicsEndImageContext();
//    return newImage;
//}
+ (instancetype)clipCircleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;

}
+ (instancetype)captureWithView:(UIView *)view{
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    // 2.将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;

}

+ (UIImage *)resizableImage:(NSString *)name{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

@end
