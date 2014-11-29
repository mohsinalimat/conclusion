//
//  ScrollTestViewController.m
//  CExpandHeaderViewExample
//
//  Created by cml on 14-8-28.
//  Copyright (c) 2014年 Mei_L. All rights reserved.
//

#import "ScrollTestViewController.h"
#import "CExpandHeader.h"
@interface ScrollTestViewController ()<UIScrollViewDelegate>

@end

@implementation ScrollTestViewController{
    
    UIScrollView *_scrollView;
    CExpandHeader *_header;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNavigationView];
    [self loadRevealController];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, DeviceWidth, DeviceHeight-64)];
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 180)];
    [imageView setImage:[UIImage imageNamed:@"image"]];
    [_scrollView setContentSize:CGSizeMake(0, 800)];
    _header = [CExpandHeader expandWithScrollView:_scrollView expandView:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
