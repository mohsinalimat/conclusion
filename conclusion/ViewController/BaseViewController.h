//
//  ViewController.h
//  conclusion
//
//  Created by Laura on 14/11/29.
//  Copyright (c) 2014年 Laura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Consts.h"

@interface BaseViewController : UIViewController

@property (nonatomic,retain) UIView *navigationView;
-(void)loadNavigationView;

-(void)loadRevealController;

-(void)loadBackButton;

-(void)loadRightButton;

-(void)setNavigationTitle:(NSString *)title;
@end

