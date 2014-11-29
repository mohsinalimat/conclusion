//
//  Tools.m
//  Qraved
//
//  Created by Shine Wang on 8/14/13.
//  Copyright (c) 2013 Imaginato. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+(double )viewEndPointX:(UIView *)view
{
    return view.frame.origin.x+view.frame.size.width;
}
+(double )viewEndPointY:(UIView *)view
{
    return view.frame.origin.y+view.frame.size.height;
}

+(BOOL)isRetinaScreen
{
    float scaleFloat= [[UIScreen mainScreen] scale];
    if(scaleFloat==1)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

+(NSString *)returnNameString:(NSString *)name
{
    if ([name stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]) {
        return [name stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    }
    return @"3423432423";
}

+(NSString *)retrunShortUserName:(NSString *)userName
{
        NSString *trimmedString = [userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        NSRange whiteSpaceRange = [trimmedString rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
//        if(whiteSpaceRange.location!=NSNotFound)
//        {
//            NSArray *separatedArray=[userName componentsSeparatedByString:@" "];
//            if (separatedArray.count<2) {
//                return @"";
//            }
//            if (![separatedArray objectAtIndex:1]) {
//                return @"";
//            }
//            NSString *firstName=[separatedArray objectAtIndex:0];
//            
//            //    NSString *lastName=[[separatedArray objectAtIndex:1] substringToIndex:1];
//            NSString *lastName=[separatedArray objectAtIndex:1];
//            
//            return [NSString stringWithFormat:@"%@ %@",firstName,lastName];
//        }
//        else
//        {
//            return userName;
//        }

    return trimmedString;
}

+(NSString *)returnPriceStamp:(NSInteger )cost
{
    switch (cost) {
        case 0:
            return @"Less than Rp. 50,000";
            break;
        case 1:
            return @"Rp. 50,000 – Rp. 100,000";
            break;
        case 2:
            return @"Rp. 100,000 – Rp. 200,000";
            break;
        case 3:
            return @"More than Rp. 200,000";
            break;
        default:
            return @"";
            break;
    }
}

+(NSString *)returnDollarString:(NSInteger)cost
{
    NSMutableString *scoreString=[[NSMutableString alloc]init];
    
    for(int i=0;i<cost;i++)
    {
        [scoreString appendFormat:@"$"];
    }
    return scoreString;
}

+(BOOL)isBlankString:(NSString *)string; {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@end
