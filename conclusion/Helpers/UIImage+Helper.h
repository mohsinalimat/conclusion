//
//  UIImage+Helper.h
//  Qraved
//
//  Created by Libo Liu on 14-2-8.
//  Copyright (c) 2014年 Imaginato. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIImage (Helper)
- (UIImage*)imageWithScaledToSize:(CGSize)newSize;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
