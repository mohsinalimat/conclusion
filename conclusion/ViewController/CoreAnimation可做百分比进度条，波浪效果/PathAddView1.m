//
//  PathAddView1.m
//  CoreAnimation
//
//  Created by zht on 14/11/27.
//  Copyright (c) 2014年 中期通. All rights reserved.
//

#import "PathAddView1.h"


@interface PathAddView1 ()
{
    UIColor *_currentWaterColor;
    
    UIImageView * imageView;
    
    int aHeight;
    BOOL isHeight;
}

@end


@implementation PathAddView1

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"22"]]];
        
        aHeight = self.frame.size.height;
        isHeight = NO;
        
        
        imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, aHeight , self.frame.size.width, 5);
        imageView.image = [UIImage imageNamed:@"yidong2"];
        imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:imageView];
        
        _currentWaterColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"11"]];
 
        
        [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
        
    }
    return self;
}

-(void)animateWave
{
    if (aHeight < 0) {
        isHeight = YES;
    }
    else if(aHeight > self.frame.size.height)
    {
        isHeight = NO;
    }
    
    imageView.frame = CGRectMake(0, aHeight , self.frame.size.width, 5);

    
    if (isHeight)  aHeight++;
    else aHeight--;
    
    
    
    
    [self setNeedsDisplay];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [_currentWaterColor CGColor]);
    
    CGContextFillRect(context, CGRectMake(0, aHeight, rect.size.width, rect.size.height - aHeight)); //画一个方框
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    

}



@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
