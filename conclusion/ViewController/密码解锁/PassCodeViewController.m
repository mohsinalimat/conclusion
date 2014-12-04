//
//  PassCodeViewController.m
//  conclusion
//
//  Created by Laura on 14/12/2.
//  Copyright (c) 2014年 Laura. All rights reserved.
//

#import "PassCodeViewController.h"
#import "DMPasscode/DMPasscode.h"

@interface PassCodeViewController (){
    UIButton* _setupButton;
    UIButton* _checkButton;
    UIButton* _removeButton;
}

@end

@implementation PassCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNavigationView];
    [self loadRevealController];
    [self addViews];
    [self updateViews];
    
}
- (void)addViews {
    _setupButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 40)];
    [_setupButton setTitle:@"Setup" forState:UIControlStateNormal];
    [_setupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_setupButton addTarget:self action:@selector(actionSetup:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_setupButton];
    
    _checkButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 40)];
    [_checkButton setTitle:@"Check" forState:UIControlStateNormal];
    [_checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_checkButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_checkButton addTarget:self action:@selector(actionCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_checkButton];
    
    _removeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 170, self.view.frame.size.width, 40)];
    [_removeButton setTitle:@"Remove" forState:UIControlStateNormal];
    [_removeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_removeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_removeButton addTarget:self action:@selector(actionRemove:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_removeButton];
}

- (void)actionSetup:(UIButton *)sender {
    [DMPasscode setupPasscodeInViewController:self completion:^(BOOL success) {
        [self updateViews];
    }];
}

- (void)actionCheck:(UIButton *)sender {
    [DMPasscode showPasscodeInViewController:self completion:^(BOOL success) {
        if (success) {
            [sender setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        } else {
            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        [self updateViews];
    }];
}

- (void)actionRemove:(id)sender {
    [DMPasscode removePasscode];
    [_checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self updateViews];
}

- (void)updateViews {
    BOOL passcodeSet = [DMPasscode isPasscodeSet];
    _checkButton.enabled = passcodeSet;
    _removeButton.enabled = passcodeSet;
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
