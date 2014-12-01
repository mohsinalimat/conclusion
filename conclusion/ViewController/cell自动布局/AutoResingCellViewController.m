//
//  HTKRootViewController.m
//  HTKDynamicResizingCell
//
//  Created by Henry T Kirk on 11/1/14.
//
//  Copyright (c) 2014 Henry T. Kirk (http://www.henrytkirk.info)
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.


#import "AutoResingCellViewController.h"
#import "HTKSampleCollectionViewController.h"
#import "HTKSampleTableViewController.h"

// Cell Identifier
static NSString *HTKRootCellIdentifier = @"HTKRootCellIdentifier";

@interface AutoResingCellViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation AutoResingCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNavigationView];
    [self loadRevealController];
    self.title = @"Menu";
    self.dataArray = @[@"CollectionView Example", @"TableView Example"];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, DeviceWidth, DeviceHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    // Register class
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HTKRootCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HTKRootCellIdentifier forIndexPath:indexPath];
    
    // Set menu title
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UIViewController *viewController = nil;
    switch (indexPath.row) {
        case 0: {
            viewController = (HTKSampleCollectionViewController *)[[HTKSampleCollectionViewController alloc] init];
            break;
                              
        }
        case 1: {
            viewController = (HTKSampleTableViewController *)[[HTKSampleTableViewController alloc] init];
            break;
            
        }
        default:
            break;
    }
    // Push on stack
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
