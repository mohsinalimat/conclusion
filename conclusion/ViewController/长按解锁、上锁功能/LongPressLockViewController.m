//
//  TestViewController.m
//  CirucularLock
//
//  Created by Cem Olcay on 10/06/14.
//  Copyright (c) 2014 studionord. All rights reserved.
//

#import "LongPressLockViewController.h"
#import "CircularLock.h"

@implementation LongPressLockViewController

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    [self loadNavigationView];
    [self loadRevealController];
    
    
    CircularLock *c = [[CircularLock alloc] initWithCenter:CGPointMake(self.view.center.x, self.view.frame.size.height - 100)
                                                    radius:50
                                                  duration:1.5
                                               strokeWidth:15
                                                 ringColor:[UIColor greenColor]
                                               strokeColor:[UIColor whiteColor]
                                               lockedImage:[UIImage imageNamed:@"lockedTransparent.png"]
                                             unlockedImage:[UIImage imageNamed:@"unlocked.png"]
                                                  isLocked:NO
                                         didlockedCallback:^{
                                             [self alertWithMessage:@"locked"];
                                         }
                                       didUnlockedCallback:^{
                                           [self alertWithMessage:@"unlocked"];
                                       }];
    [self.view addSubview:c];
}

- (void)alertWithMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
