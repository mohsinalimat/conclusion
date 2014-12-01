//
//  ViewController.m
//  DKTagCloudViewDemo
//
//  Created by ZhangAo on 14-11-18.
//  Copyright (c) 2014年 zhangao. All rights reserved.
//

#import "TagCloudViewController.h"
#import "DKTagCloudView.h"

@interface TagCloudViewController ()

@property (nonatomic, weak) DKTagCloudView *tagCloudView;

@end

@implementation TagCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNavigationView];
    [self loadRevealController];
    [self loadRightButton];
    DKTagCloudView *tagCloudView = [[DKTagCloudView alloc] initWithFrame:CGRectMake(0, 64,
                                                                                    self.view.bounds.size.width,
                                                                                    self.view.bounds.size.height - 64)];
    [self.view addSubview:tagCloudView];
    self.tagCloudView = tagCloudView;
    
    self.tagCloudView.maxFontSize = 20;
    self.tagCloudView.titls = @[
                                @"DKTagCloudView",
                                @"minFontSize",
                                @"maxFontSize",
                                @"randomColors",
                                @"generate",
                                @"UIView",
                                @"NSInteger",
                                @"Min font size",
                                @"Max font size",
                                @"DKTagCloudViewDemo",
                                @"This is a test"
                                ];
    [self.tagCloudView setTagClickBlock:^(NSString *title, NSInteger index) {
        NSLog(@"title:%@,index:%zd",title,index);
    }];
}
-(void)loadRightButton
{
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setFrame:CGRectMake(DeviceWidth-80.0f, 20.0f, 80.0f, 44.0f)];
    [rightBarButton addTarget:self action:@selector(regenerate:) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBarButton setTitle:@"Generate" forState:UIControlStateNormal];
    rightBarButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    
    [self.navigationView addSubview:rightBarButton];
}


- (IBAction)regenerate:(id)sender {
    [self.tagCloudView generate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
