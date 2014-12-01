//
//  FirstViewController.m
//  LockSample
//
//  Created by Lugede on 14/11/11.
//  Copyright (c) 2014年 lugede.cn All rights reserved.
//

#import "LockFirstViewController.h"
#import "AppDelegate.h"

@interface LockFirstViewController ()
{
}

@end

@implementation LockFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadNavigationView];
    [self loadRevealController];
    UIButton *lockButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lockButton.frame = CGRectMake(100, 100, DeviceWidth-200, 40);
    [lockButton setTitle:@"锁定" forState:UIControlStateNormal];
    [lockButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lockButton addTarget:self action:@selector(lockButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lockButton];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lockButtonPressed:(id)sender {
    [[AppDelegate ShareApp] showLLLockViewController:LLLockViewTypeCheck];
}


@end
