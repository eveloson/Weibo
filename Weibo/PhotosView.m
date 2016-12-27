//
//  PhotosView.m
//  Weibo
//
//  Created by 吴斌 on 16/12/26.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "PhotosView.h"
#import "PhotoView.h"
#import "ImageSize.h"
#import "Photo.h"
#import <MJPhoto.h>
#import <MJPhotoBrowser.h>
@implementation PhotosView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化9个子控件
        for (int i = 0; i<9; i++) {
            PhotoView *photoView = [[PhotoView alloc] init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
        }

    }
    return self;
}

- (void)photoTap:(UITapGestureRecognizer *)recognizer{
    NSUInteger count = self.photos.count;
    //1.封装图片数据
    NSMutableArray *mjPhotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        //传原图url
        photo.url = [NSURL URLWithString:[[self.photos[i] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"]];
        photo.srcImageView = self.subviews[i];
        [mjPhotos addObject:photo];
    }
    //2.显示相册
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    brower.currentPhotoIndex = recognizer.view.tag;
    brower.photos = mjPhotos;
    [brower show];
}
- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    for (int i = 0; i < self.subviews.count; i++) {
        // 取出i位置对应的imageView
        PhotoView *photoView = self.subviews[i];
        
        // 判断这个imageView是否需要显示数据
        if (i < photos.count) {
            // 显示图片
            photoView.hidden = NO;
            
            // 传递模型数据
            photoView.photo = photos[i];
            
            // 设置子控件的frame
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int col = i % maxColumns;
            int row = i / maxColumns;
            CGFloat photoX = col * (PhotoW + PhotoMargin);
            CGFloat photoY = row * (PhotoH + PhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, PhotoW, PhotoH);
            
            // Aspect : 按照图片的原来宽高比进行缩
            // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
            // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
            // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
            
            if (photos.count == 1) {
                photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        } else { // 隐藏imageView
            photoView.hidden = YES;
        }

    }
}
+ (CGSize)photosViewSizeWithPhotosCount:(int)count
{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * PhotoH + (rows - 1) * PhotoMargin;
        
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * PhotoW + (cols - 1) * PhotoMargin;
    return CGSizeMake(photosW, photosH);
    /**
     一共60条数据 == count
     一页10条 == size
     总页数 == pages
     pages = (count + size - 1)/size;
     */
}

+ (CGSize)photosViewSizeWithPhoto:(Photo *)photo{
    CGSize photoSize = [ImageSize getImageSizeWithURL:photo.thumbnail_pic];
    CGFloat photoW = photoSize.width;
    CGFloat photoH = photoSize.height;
    CGFloat photosW;
    CGFloat photosH;
    if (photoW > photoH) {
        photosW = PhotoW * 2 + PhotoMargin;
        photosH = PhotoW * 1.5 + PhotoMargin;
    } else if (photosW < photoH){
        photosW = PhotoW * 1.5 + PhotoMargin;
        photosH = PhotoH * 2 + PhotoMargin;;
    } else {
        photosW = photosH = PhotoH * 2 + PhotoMargin;
    }
    return CGSizeMake(photosW, photosH);
}

@end
