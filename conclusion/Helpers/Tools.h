//
//  Tools.h
//  Qraved
//
//  Created by Shine Wang on 8/14/13.
//  Copyright (c) 2013 Imaginato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tools : NSObject
+(NSString *)returnNameString:(NSString *)name;
+(NSString *)retrunShortUserName:(NSString *)userName;
+(NSString *)returnPriceStamp:(NSInteger)cost;
+(NSString *)returnDollarString:(NSInteger)cost;
+(double )viewEndPointX:(UIView *)view;
+(double )viewEndPointY:(UIView *)view;
+(BOOL)isRetinaScreen;
+(BOOL)isBlankString:(NSString *)string;
@end
