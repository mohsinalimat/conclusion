//
//  SecondViewController.m
//  LockSample
//
//  Created by Lugede on 14/11/11.
//  Copyright (c) 2014年 lugede.cn All rights reserved.
//

#import "LockSecondViewController.h"
#import "AppDelegate.h"

#define kLableArray @[@"创建密码", @"修改密码", @"清除密码"]

@interface LockSecondViewController ()
{
    NSArray* heightArray;
}
@property (retain, nonatomic) UITableView *settingTableView;

@end

@implementation LockSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadNavigationView];
    [self loadRevealController];
    
    if ([LLLockPassword loadLockPassword]) {
        heightArray = @[@"0.0", @"50.0", @"50.0"];
    } else {
        heightArray = @[@"50.0", @"0.0", @"0.0"];
    }
    
    self.settingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, DeviceWidth, DeviceHeight-64) style:UITableViewStylePlain];
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
    [self.view addSubview:self.settingTableView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((NSNumber*)(heightArray[indexPath.row])).floatValue;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ident = @"SettingCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    cell.textLabel.text = kLableArray[indexPath.row];
    cell.clipsToBounds = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [[AppDelegate ShareApp] showLLLockViewController:LLLockViewTypeCreate];
            break;
        case 1:
            [[AppDelegate ShareApp] showLLLockViewController:LLLockViewTypeModify];
            break;
        default:
            [[AppDelegate ShareApp] showLLLockViewController:LLLockViewTypeClean];
            break;
    }
}


@end
