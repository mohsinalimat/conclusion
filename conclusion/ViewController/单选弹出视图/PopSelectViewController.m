//
//  PopSelectViewController.m
//  conclusion
//
//  Created by Laura on 14/11/29.
//  Copyright (c) 2014年 Laura. All rights reserved.
//

#import "PopSelectViewController.h"
#import "SGPopSelectView.h"

@interface PopSelectViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSArray *selections;
@property (nonatomic, strong) SGPopSelectView *popView;

@end

@implementation PopSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavigationView];
    [self loadRevealController];
    // Do any additional setup after loading the view from its nib.
    self.selections = @[@"Shake It Off",@"All About that Bass",@"Animals",@"Take Me To Church",@"Out Of The Woods",@"Centuries",@"I'm Not the Only One",@"Burnin' It Down"];
    self.popView = [[SGPopSelectView alloc] init];
    self.popView.selections = self.selections;
    __weak typeof(self) weakSelf = self;
    self.popView.selectedHandle = ^(NSInteger selectedIndex){
        NSLog(@"selected index %ld, content is %@", selectedIndex, weakSelf.selections[selectedIndex]);
    };

}
- (IBAction)showAction:(id)sender {
    CGPoint p = [(UIButton *)sender center];
    [self.popView showFromView:self.view atPoint:p animated:YES];
}

- (IBAction)tapAction:(UIGestureRecognizer *)sender {
    [self.popView hide:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.view];
    if (self.popView.visible && CGRectContainsPoint(self.popView.frame, p)) {
        return NO;
    }
    return YES;
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
