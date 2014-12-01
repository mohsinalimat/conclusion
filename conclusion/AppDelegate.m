//
//  AppDelegate.m
//  conclusion
//
//  Created by Laura on 14/11/29.
//  Copyright (c) 2014年 Laura. All rights reserved.
//

#import "AppDelegate.h"
#import "AutoScrollViewController.h"
#import "MLNavigationController.h"
#import "LeftMenuViewController.h"
#import "Consts.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

+(AppDelegate *)ShareApp
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
-(void)customizeAppearance
{
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor],UITextAttributeTextColor,[UIFont fontWithName:DEFAULT_FONT_NAME size:18],UITextAttributeFont, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [self customizeAppearance];
    
    AutoScrollViewController *_homeViewController = [[AutoScrollViewController alloc]init];
    MLNavigationController *_homeNavigationController=[[MLNavigationController alloc] initWithRootViewController:_homeViewController];
    LeftMenuViewController *mainMenu=[[LeftMenuViewController alloc]init];
    _revealController = [[SWRevealViewController alloc] initWithRearViewController:mainMenu frontViewController:_homeNavigationController];
    self.window.rootViewController=_revealController;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - 弹出手势解锁密码输入框
- (void)showLLLockViewController:(LLLockViewType)type
{
    if(self.window.rootViewController.presentingViewController == nil){
        
        LLLog(@"root = %@", self.window.rootViewController.class);
        LLLog(@"lockVc isBeingPresented = %d", [self.lockVc isBeingPresented]);
        
        self.lockVc = [[LLLockViewController alloc] init];
        self.lockVc.nLockViewType = type;
        
        self.lockVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self.window.rootViewController presentViewController:self.lockVc animated:NO completion:^{
        }];
        LLLog(@"创建了一个pop=%@", self.lockVc);
    }
}



@end
