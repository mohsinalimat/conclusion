//
//  NSString+Helper.m
//  Qraved
//
//  Created by Shine Wang on 9/30/13.
//  Copyright (c) 2013 Imaginato. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>
#import "Consts.h"
#import "Tools.h"
#import "Consts.h"

@implementation NSString (Helper)
-(NSString *)filterHtml
{
    NSString *returnString= [[[self stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]  stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"] stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
//    DLog(@"return String is %@",returnString);
    return returnString ;
}

-(NSString *)promotionsHTML
{
    //    NSLog(@"%@",modifiedHTML);
    //    return modifiedHTML;
    
    NSString *returnString= [[[self stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]  stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"] stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    NSString *prexHtml=@"<html><style type='text/css'>img { max-width: 100%; width: auto; height: auto; }</style><head><meta name=\"viewport\" content=\"width=300, initial-scale=1.0,maximum-scale=3.0, minimum-scale=0.5, user-scalable=yes,target-densitydpi=device-dpi\" /></head><body>";
    NSString *suffixHtml=@"</body></html>";
    returnString=[prexHtml stringByAppendingString:returnString];
    returnString=[returnString stringByAppendingString:suffixHtml];
    
//    DLog(@"after modfied url is %@",returnString);
    return  returnString;
}

-(NSString *)changeStyle
{
    NSString *originHTML=self;
    UIFont *font=[UIFont fontWithName:DEFAULT_FONT_NAME size:15];
    return [NSString stringWithFormat:@"<span style=\"font-family: %@;color:5F5F5F; font-size: %f\">%@</span>",
            font.fontName,
            15.0,
            originHTML];
}

-(NSString *)replaceUrlString
{
    NSString *originalHTML = [self filterHtml];
    NSString *regexPattern = @"<img[^>]*width:['\"\\s]*([0-9]+)[^>]*height:['\"\\s]*([0-9]+)[^>]*>";
    
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:regexPattern
                                              options:NSRegularExpressionDotMatchesLineSeparators
                                                error:nil];
    NSMutableString *modifiedHTML = [NSMutableString stringWithString:originalHTML];
    
    NSArray *matchesArray=[regex matchesInString:modifiedHTML options:NSMatchingReportProgress range:NSMakeRange(0, [modifiedHTML length])];
    
    NSTextCheckingResult *match;
    
    NSInteger offset = 0, newoffset = 0;
    
    int maxWidth = 300;
    
    for (match in matchesArray) {
        
        NSRange widthRange = [match rangeAtIndex:1];
        NSRange heightRange = [match rangeAtIndex:2];
        
        widthRange.location += offset;
        heightRange.location += offset;
        
        NSString *widthStr = [modifiedHTML substringWithRange:widthRange];
        NSString *heightStr = [modifiedHTML substringWithRange:heightRange];
        
        int width = [widthStr intValue];
        int height = [heightStr intValue];
        
        if (width > maxWidth) {
            height = (height * maxWidth) / width;
            width = maxWidth;
            
            NSString *newWidthStr = [NSString stringWithFormat:@"%d", width];
            NSString *newHeightStr = [NSString stringWithFormat:@"%d", height];
            
            [modifiedHTML replaceCharactersInRange:widthRange withString:newWidthStr];
            
            newoffset = ([newWidthStr length] - [widthStr length]);
            heightRange.location += newoffset;
            
            [modifiedHTML replaceCharactersInRange:heightRange withString:newHeightStr];
            
            newoffset += ([newHeightStr length] - [heightStr length]);
            offset += newoffset;
        }
    }
    
    return modifiedHTML;

}

-(NSString *)filterNullString
{
    return [[self stringByReplacingOccurrencesOfString:@"<null>" withString:@""]  stringByReplacingOccurrencesOfString:@"null" withString:@""];
}

-(BOOL)isValidateUsername{
    
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    if (self.length<3 || trimmedString.length==0) {
        return NO;
    }
    return YES;
}
-(BOOL)isValidateEmail{

    if (self.length<1) {
        return NO;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(BOOL)isValidatePhone{
    
    if (self.length<8||self.length>17) {
        return NO;
    }
    return YES;

}


-(BOOL)isValidateInternationPhone
{
    if (self.length<1) {
        return NO;
    }
    NSString *numberRegex = @"^(\\+?)(\\d{10,15})$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numberTest evaluateWithObject:[self stringByReplacingOccurrencesOfString:@"-" withString:@""]];
}


-(BOOL)isBlankString{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (NSDate *)dateFromString{
    NSString *dateString=self;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}

-(NSString *)returnShortPhoneNum
{
    if([self hasPrefix:@"+"])
    {
        return [self substringFromIndex:3];
    }
    
    return self;
}
//-(NSString *)returnFullImageUrl
//{
//    NSString* encodedUrl = [self stringByAddingPercentEscapesUsingEncoding:
//                            NSASCIIStringEncoding];
//    return [QRAVED_WEB_IMAGE_SERVER stringByAppendingString:encodedUrl];
//
//}
//
-(NSString *)returnFullImageUrlWithWidth:(CGFloat )width
{
    CGFloat realWidth=width;
    if([Tools isRetinaScreen])
    {
        realWidth=width*2;
    }
    NSString* encodedUrl = [self stringByAddingPercentEscapesUsingEncoding:
                            NSASCIIStringEncoding];
    if(encodedUrl!=NULL)
    {
    return [[IMAGINATO_WEB_IMAGE_SERVER stringByAppendingString:encodedUrl] stringByAppendingFormat:@"&width=%f",realWidth];
    }
    return @"";
}

-(NSString *)MD5String
{
    /*
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
     
     */
    
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
- (NSString *)toFormatNumberString{
    @try
    {
        if (self.length < 3)
        {
            return self;
        }
        NSString *numStr = self;
        NSArray *array = [numStr componentsSeparatedByString:@"."];
        NSString *numInt = [array objectAtIndex:0];
        if (numInt.length <= 3)
        {
            return self;
        }
        NSString *suffixStr = @"";
        if ([array count] > 1)
        {
            suffixStr = [NSString stringWithFormat:@".%@",[array objectAtIndex:1]];
        }
        
        NSMutableArray *numArr = [[NSMutableArray alloc] init];
        while (numInt.length > 3)
        {
            NSString *temp = [numInt substringFromIndex:numInt.length - 3];
            numInt = [numInt substringToIndex:numInt.length - 3];
            [numArr addObject:[NSString stringWithFormat:@",%@",temp]];//得到的倒序的数据
        }
        NSUInteger count = [numArr count];
        for (int i = 0; i < count; i++)
        {
            numInt = [numInt stringByAppendingFormat:@"%@",[numArr objectAtIndex:(count -1 -i)]];
        }
    
        numStr = [NSString stringWithFormat:@"%@%@",numInt,suffixStr];
        return numStr;
    }
    @catch (NSException *exception)
    {
        return self;
    }
    @finally
    {}
    
}
- (NSString *)removeHTML{
    NSString *html = [NSString stringWithString:self];
    NSScanner *theScanner;
    
    NSString *text = nil;
    /*
      str = str.replace("&lt;", "<");
      str = str.replace("&gt;", ">");
      str = str.replace("<ol>", "<p>");
      str = str.replace("</ol>", "</p>");
      str = str.replace("<li>", " ");
      str = str.replace("</li>", "<br>");
      return str;
     */
    
    html = [html stringByReplacingOccurrencesOfString:@"&amp;amp;" withString:@"&"];
    html = [html stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    html = [html stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    html = [html stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        
        
        // find end of tag
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        
        
        // replace the found tag with a space
        
        //(you can filter multi-spaces out later if you wish)
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
        
        
        
    }
    
    return html;
    
}
- (NSString *)removeHTML2{
    NSString *html = [NSString stringWithString:self];
    NSArray *components = [html componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    
    
    NSMutableArray *componentsToKeep = [NSMutableArray array];
    
    for (int i = 0; i < [components count]; i = i + 2) {
        
        [componentsToKeep addObject:[components objectAtIndex:i]];
        
    }
    
    
    
    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
    
    return plainText;
    
}

-(BOOL)isLogout{
    if ([self isEqualToString:@"Please sign in first."]) {
        return YES;
    }
    return NO;
}

-(NSString *)groupConcat:(NSArray *)stringArray
{
    if(stringArray!=nil){
        NSString *tmpStr = @"";
        for(NSString *str in stringArray){
            if([tmpStr length]>0){
                tmpStr = [[NSString alloc] initWithFormat:@"%@, %@",tmpStr,str];
            }else{
                tmpStr = [[NSString alloc] initWithFormat:@"%@%@",tmpStr,str];
            }
        }
        return tmpStr;
    }
    return @"";
}

-(NSString *)groupConcat:(NSArray *)stringArray length:(int)length
{
    if(stringArray!=nil){
        NSString *tmpStr = @"";
        for(int i=0;i<length && i<stringArray.count;i++){
            NSString *str = stringArray[i];
            if([tmpStr length]>0){
                tmpStr = [[NSString alloc] initWithFormat:@"%@, %@",tmpStr,str];
            }else{
                tmpStr = [[NSString alloc] initWithFormat:@"%@%@",tmpStr,str];
            }
        }
        return tmpStr;
    }
    return @"";
}

-(NSString *)html
{
    //    NSLog(@"%@",modifiedHTML);
    //    return modifiedHTML;
    
    NSString *returnString= [[[self stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]  stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"] stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    NSString *prexHtml=@"<html><style type='text/css'>img { max-width: 100%; width: auto; height: auto; }</style><head><meta name=\"viewport\" content=\"width=300, initial-scale=1.0,maximum-scale=3.0, minimum-scale=0.5, user-scalable=yes,target-densitydpi=device-dpi\" /></head><body>";
    NSString *suffixHtml=@"</body></html>";
    returnString=[prexHtml stringByAppendingString:returnString];
    returnString=[returnString stringByAppendingString:suffixHtml];
    
    //    DLog(@"after modfied url is %@",returnString);
    return  returnString;
}

@end
