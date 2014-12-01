//
//  ViewController.m
//  DBSphereTagCloud
//
//  Created by Xinbao Dong on 14/9/1.
//  Copyright (c) 2014年 Xinbao Dong. All rights reserved.
//

#import "SphereTagCloudViewController.h"
#import "DBSphereView.h"

@interface SphereTagCloudViewController ()

@property (nonatomic, retain) DBSphereView *sphereView;

@end

@implementation SphereTagCloudViewController

@synthesize sphereView;
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNavigationView];
    [self loadRevealController];
    
    sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(0, 120, DeviceWidth, DeviceWidth)];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < 50; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:[NSString stringWithFormat:@"P%ld", i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:24.];
        btn.frame = CGRectMake(0, 0, 60, 20);
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:btn];
        [sphereView addSubview:btn];
    }
    [sphereView setCloudTags:array];
    sphereView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sphereView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)buttonPressed:(UIButton *)btn
{
    [sphereView timerStop];
    
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [sphereView timerStart];
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
