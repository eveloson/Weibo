//
//  ImageSize.h
//  Weibo
//
//  Created by 吴斌 on 16/12/27.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageSize : NSObject
singleton_interface(ImageSize)
+ (CGSize)getImageSizeWithURL:(id)imageURL;
@end
