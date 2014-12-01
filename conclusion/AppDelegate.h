//
//  AppDelegate.h
//  conclusion
//
//  Created by Laura on 14/11/29.
//  Copyright (c) 2014年 Laura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "LLLockViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic)SWRevealViewController *revealController;
+(AppDelegate *)ShareApp;


// 手势解锁相关
@property (strong, nonatomic) LLLockViewController* lockVc; // 添加解锁界面
- (void)showLLLockViewController:(LLLockViewType)type;

@end

