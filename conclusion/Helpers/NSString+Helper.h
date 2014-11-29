//
//  NSString+Helper.h
//  Qraved
//
//  Created by Shine Wang on 9/30/13.
//  Copyright (c) 2013 Imaginato. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NSString (Helper)
-(NSString *)filterHtml;
-(NSString *)promotionsHTML;
-(NSString *)changeStyle;
-(NSString *)filterNullString;
-(NSString *)replaceUrlString;


-(BOOL)isValidateUsername;
-(BOOL)isValidateEmail;
-(BOOL)isValidatePhone;
-(BOOL)isValidateInternationPhone;

-(BOOL)isBlankString;
-(NSDate *)dateFromString;
-(NSString *)returnShortPhoneNum;   //delete country code +62;
-(NSString *)MD5String;
- (NSString *)toFormatNumberString;
- (NSString *)removeHTML;
- (NSString *)removeHTML2;
-(NSString *)html;
-(BOOL)isLogout;

-(NSString *)groupConcat:(NSArray *)stringArray;
-(NSString *)groupConcat:(NSArray *)stringArray length:(int)length;

@end
