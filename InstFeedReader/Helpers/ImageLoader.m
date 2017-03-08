//
//  ImageLoader.m
//  InstFeedReader
//
//  Created by Gennadii on 3/8/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

#import "ImageLoader.h"

@implementation ImageLoader

/*
 imageManager:transformDownloadedImage:withURL:
 overriden method for SDWebImageManagerDelegate
 resize image before store in cache
 */
- (UIImage *)imageManager:(SDWebImageManager *)imageManager
 transformDownloadedImage:(UIImage *)image
                  withURL:(NSURL *)imageURL
{
    
    CGSize resultImageSize;
    CGFloat height;
    CGFloat width;
    if (image.size.height > image.size.width) {
        
        height = 52.0f;
        width = image.size.width * height / image.size.height;
    } else {
        width = 52.0f;
        height = image.size.height * width / image.size.width;
    }
    resultImageSize = CGSizeMake(width, height);

    UIGraphicsBeginImageContext(resultImageSize);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
