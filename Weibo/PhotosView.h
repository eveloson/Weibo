//
//  PhotosView.h
//  Weibo
//
//  Created by 吴斌 on 16/12/26.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Photo;
@interface PhotosView : UIView
/**
 *  需要展示的图片(数组里面装的都是IWPhoto模型)
 */
@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片的个数返回相册的最终尺寸
 */
+ (CGSize)photosViewSizeWithPhotosCount:(int)count;
+ (CGSize)photosViewSizeWithPhoto:(Photo *)photo;
@end
