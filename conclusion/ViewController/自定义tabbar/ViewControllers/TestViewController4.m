//
//  TestViewController4.m
//  Example
//
//  Created by Nicolas Goles on 6/7/14.
//  Copyright (c) 2014 Goles. All rights reserved.
//

#import "TestViewController4.h"

@interface TestViewController4 ()

@end

@implementation TestViewController4

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[UIImage imageNamed:@"cloud_normal"]
                                                selectedImage:[UIImage imageNamed:@"cloud_pressed"]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadNavigationView];
    [self loadRevealController];
    [self setNavigationTitle:@"Test View Controller 4"];
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
