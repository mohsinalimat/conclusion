//
//  ViewController.m
//  conclusion
//
//  Created by Laura on 14/11/29.
//  Copyright (c) 2014年 Laura. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    self.navigationController.navigationBarHidden = YES;
    
    
}

-(void)loadNavigationView
{
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 64)];
    _navigationView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_navigationView];
}
-(void)setNavigationTitle:(NSString *)title
{
    CGSize expectSize = [title sizeWithFont:[UIFont fontWithName:DEFAULT_FONT_BOLD_NAME size:18]];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(DeviceWidth/2-expectSize.width/2, 20+44/2-expectSize.height/2, expectSize.width, expectSize.height)];
    titleLabel.textColor = [ UIColor whiteColor];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:DEFAULT_FONT_BOLD_NAME size:18];
    [_navigationView addSubview:titleLabel];
}

-(void)loadRevealController
{
    SWRevealViewController *leftRevealController= [AppDelegate ShareApp].revealController;
    
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setFrame:CGRectMake(0.0f, 20.0f, 80.0f, 44.0f)];
    [rightBarButton addTarget:leftRevealController action:@selector(revealToggleAnimated:) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setImage:[UIImage imageNamed:@"ListTop"] forState:UIControlStateNormal];
    rightBarButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [_navigationView addSubview:rightBarButton];
    
    [self.view addGestureRecognizer:leftRevealController.panGestureRecognizer];
    
}

-(void)loadBackButton
{
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton setFrame:CGRectMake(0.0f, 20.0f, 80.0f, 44.0f)];
    [leftBarButton addTarget:self action:@selector(goToBackViewController) forControlEvents:UIControlEventTouchUpInside];
    [leftBarButton setImage:[UIImage imageNamed:@"BackTop"] forState:UIControlStateNormal];
    leftBarButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    
    [_navigationView addSubview:leftBarButton];
}

-(void)loadRightButton
{
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setFrame:CGRectMake(DeviceWidth-80.0f, 20.0f, 80.0f, 44.0f)];
    [rightBarButton addTarget:self action:@selector(goToBackViewController) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setImage:[UIImage imageNamed:@"BackTop"] forState:UIControlStateNormal];
    rightBarButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    
    [_navigationView addSubview:rightBarButton];
}


-(void)goToBackViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
