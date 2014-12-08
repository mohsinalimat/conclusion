//
//  RootViewController.m
//  TestParseHTML
//
//  Created by Adam on 13-10-8.
//  Copyright (c) 2013年 Adam. All rights reserved.
//

#import "HtmlParserViewController.h"
#import "HTMLParser.h"
#import "FDLabelView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIImageView+WebCache.h"

@interface HtmlParserViewController ()
{
    CGFloat currentY;
    UIScrollView *mScrollView;
}
@end

@implementation HtmlParserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNavigationView];
    [self loadRevealController];
    currentY = 40;
    
    mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, DeviceWidth, DeviceHeight-64)];
    [self.view addSubview:mScrollView];
    
    [self parseHTML];
}

- (void)parseHTML {
    NSString *readmePath = [[NSBundle mainBundle] pathForResource:@"iOS6" ofType:@"html"];
		NSString *html = [NSString stringWithContentsOfFile:readmePath encoding:NSUTF8StringEncoding error:NULL];
    html = [html stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
        return;
    }
    
    HTMLNode *bodyNode = [parser body];
    NSArray *inputNodes = [bodyNode children];
    
    for (HTMLNode *node in inputNodes) {
        
        if (node.nodetype == HTMLIFrame) {
            [self addVideoPlayer:[node getAttributeNamed:@"src"]];
        }		
        
        NSArray *childNodes = [node children];
        if (childNodes.count > 0) {
            if (childNodes.count == 1) {
                HTMLNode *theNode = [childNodes objectAtIndex:0];
                if (theNode.nodetype == HTMLImageNode) {
                    [self addSubImageView:[theNode getAttributeNamed:@"src"]];
                }
                if (theNode.nodetype == HTMLStrongNode) {
                    [self addSubStrongText:theNode.contents];
                }
                if (theNode.nodetype == HTMLTextNode) {
                    [self addSubText:theNode.rawContents];
                }
                
            }else{
                if (node.nodetype == HTMLBlockQuoteNode) {
                    for (HTMLNode *node1 in childNodes) {
                        if (node1.nodetype == HTMLPNode) {

                            [self addBlockQuoteView:node1.contents];
                        }
                    }
                }else{
                    NSMutableString *contentString = [[NSMutableString alloc]init];
                    for (HTMLNode *node1 in childNodes) {
                        if (node1.nodetype == HTMLTextNode) {
                            [contentString appendString:node1.rawContents];
                            if (node1.nextSibling.nodetype != HTMLHrefNode) {
                                [contentString appendString:@"\n"];
                            }
                        }
                        if (node1.nodetype == HTMLHrefNode) {
                            [contentString appendString:node1.contents];
                        }
                    }
                    [self addSubText:contentString];
                }
                
            }
        }
        
    }
    
}

- (void)addSubImageView:(NSString *)imageURL {
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];

    CGFloat height = (self.view.frame.size.width-30)/img.size.width * img.size.height;
    CGRect rect = CGRectMake(15, currentY, self.view.frame.size.width-30, height);
    currentY += height + 10;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    [imageView setImage:img];
    
    CALayer *layer=[imageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:10.0];
    [layer setBorderWidth:1];
    [layer setBorderColor:[[UIColor blackColor] CGColor]];
    [mScrollView addSubview:imageView];
}

//添加引用
- (void)addBlockQuoteView:(NSString *)content {
    content = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(20, currentY, 280, 0)];
    titleView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:13];
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 0;
    titleView.text = content;
    titleView.lineHeightScale = 0.90;
    titleView.fixedLineHeight = 0.00;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentLeft;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [mScrollView addSubview:titleView];
    
    currentY += titleView.visualTextHeight + 10;
    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, currentY)];
}

//添加文章标题
- (void)addSubStrongText:(NSString *)content {

    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(10, currentY, 300, 0)];
    titleView.backgroundColor = [UIColor redColor];
    titleView.textColor = [UIColor colorWithHue:0.57 saturation:0.87 brightness:0.82 alpha:0.80];
    titleView.font = [UIFont boldSystemFontOfSize:18];
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 0;
    titleView.text = content;
    titleView.lineHeightScale = 0.90;
    titleView.fixedLineHeight = 0.00;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentLeft;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [mScrollView addSubview:titleView];
    currentY += titleView.visualTextHeight;
    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, currentY)];
}

//添加文章段落
- (void)addSubText:(NSString *)content {
    
    
    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(10, currentY, 300, 0)];
    titleView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.00];
    titleView.textColor = [UIColor blackColor];
    titleView.font = [UIFont systemFontOfSize:16];
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 0;
    titleView.text = content;
    titleView.lineHeightScale = 0.80;
    titleView.fixedLineHeight = 20;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentLeft;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [mScrollView addSubview:titleView];
    
    currentY += titleView.visualTextHeight + 10;
    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, currentY)];
    
    titleView.debug = NO;
}

- (void)addVideoPlayer:(NSString *)urlStr {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    UIWebView *videoWeb = [[UIWebView alloc]initWithFrame:CGRectMake(10, currentY, 300, 190)];
    [videoWeb loadRequest:[NSURLRequest requestWithURL:url]];
    [mScrollView addSubview:videoWeb];
    currentY += 190 + 10;
    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, currentY)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
