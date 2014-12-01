//
//  TextFieldResignFirstResponderViewController.m
//  conclusion
//
//  Created by Laura on 14/12/1.
//  Copyright (c) 2014年 Laura. All rights reserved.
//

#import "TextFieldResignFirstResponderViewController.h"
#import "InputHelper.h"
@interface TextFieldResignFirstResponderViewController ()

@end

@implementation TextFieldResignFirstResponderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [inputHelper setupInputHelperForView:self.view withDismissType:InputHelperDismissTypeTapGusture];

    [self loadNavigationView];
    [self loadRevealController];
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
