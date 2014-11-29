//
//  UIView+Helper.m
//  Qraved
//
//  Created by Libo Liu on 10/8/13.
//  Copyright (c) 2013 Imaginato. All rights reserved.
//

#import "UIView+Helper.h"
@implementation UIView (Helper)


-(CGFloat)endPointX
{
    return self.frame.origin.x+self.frame.size.width;
}
-(CGFloat)endPointY
{
    return self.frame.origin.y+self.frame.size.height;
}
-(CGFloat)startPointX
{
    return self.frame.origin.x;
}
-(CGFloat)startPointY
{
    return self.frame.origin.y;
}
@end
