//
//  AutoScrollViewController.m
//  conclusion
//
//  Created by Laura on 14/11/29.
//  Copyright (c) 2014年 Laura. All rights reserved.
//

#import "AutoScrollViewController.h"
#import "EScrollerView.h"


@interface AutoScrollViewController ()<EScrollerViewDelegate>

@end

@implementation AutoScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNavigationView];
    [self loadRevealController];
    [self addBannerView];
    
}
-(void)addBannerView
{
    NSArray *bannerArray = @[@"http://img.mingxing.com/upload/attach/2014/03/54187-7R31FDF.jpg",@"http://img.mingxing.com/upload/attach/2014/03/54187-9M3MDPS.jpg",@"http://g.hiphotos.baidu.com/image/pic/item/42166d224f4a20a498fb50c693529822730ed0ce.jpg"];
    EScrollerView*_bannerView = [[EScrollerView alloc]initWithFrameRect:CGRectMake(0, 64, DeviceWidth, DeviceHeight-64) ImageArray:bannerArray TitleArray:nil];
    [_bannerView setDelegate:self];
    [_bannerView startScrolling];
    [self.view addSubview:_bannerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
