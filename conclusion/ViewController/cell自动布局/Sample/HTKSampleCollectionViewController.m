//
//  HTKSampleCollectionViewController.m
//  HTKDynamicResizingCell
//
//  Created by Henry T Kirk on 10/31/14.
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


#import "HTKSampleCollectionViewController.h"
#import "HTKDynamicResizingCollectionViewCell.h"
#import "HTKSampleCollectionViewCell.h"

/**
 * Cell identifier for the sample cell
 */
static NSString *HTKSampleCollectionViewCellIdentifier = @"HTKSampleCollectionViewCellIdentifier";

@interface HTKSampleCollectionViewController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

/**
 * Array that holds our sample data
 */
@property (nonatomic, retain)UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *dataArray;

@end

@implementation HTKSampleCollectionViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {

    self.title = @"CollectionView Sample";

    self.dataArray = [[NSMutableArray alloc]init];
    // Load sample data into the array
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SampleData" ofType:@"plist"];
    [self.dataArray addObjectsFromArray:[NSArray arrayWithContentsOfFile:filePath]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadNavigationView];
    [self loadBackButton];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 1;
    flowLayout.sectionInset = UIEdgeInsetsZero;
//    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
//    flowLayout.minimumLineSpacing = 10.0;//行间距(最小值)
//    flowLayout.minimumInteritemSpacing = 50.0;//item间距(最小值)
//    flowLayout.itemSize = CGSizeMake(50, 50);//item的大小
//    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//设置section的边距
//    flowLayout.headerReferenceSize = CGSizeMake(DeviceWidth, 20);
//    flowLayout.footerReferenceSize = CGSizeMake(DeviceWidth, 20);
    //第二个参数是cell的布局
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, DeviceWidth, DeviceHeight-64) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor orangeColor];
    
    // Register our cell
    //1 注册复用cell(cell的类型和标识符)(可以注册多个复用cell, 一定要保证重用标示符是不一样的)注册到了collectionView的复用池里
    [_collectionView registerClass:[HTKSampleCollectionViewCell class] forCellWithReuseIdentifier:HTKSampleCollectionViewCellIdentifier];
    
    //第一个参数:返回的View类型
    //第二个参数:设置View的种类(header, footer)
    //第三个参数:设置重用标识符
    //    [_collectionView registerClass:[HeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    //    [_collectionView registerClass:[FootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
    [self.view addSubview:_collectionView];
    
    [_collectionView reloadData];
    
}

#pragma mark - UICollectionView Delegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get cell
    HTKSampleCollectionViewCell *cell = (HTKSampleCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:HTKSampleCollectionViewCellIdentifier forIndexPath:indexPath];
    
    // Load data
    NSDictionary *dataDict = self.dataArray[indexPath.row];
    // Sample image
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%i", arc4random_uniform(10) + 1]];
    [cell setupCellWithData:dataDict andImage:image];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    CGSize defaultSize = DEFAULT_CELL_SIZE;
    
    // Create our size
    return [HTKSampleCollectionViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<HTKDynamicResizingCellProtocol> cellToSetup) {
        // set values - there's no need to set the image here
        // because we have height and width constraints set, so
        // nil image will end up measuring to that size. If you don't
        // set the image contraints, it will end up being it's 1x intrinsic
        // size of the image, so you should set a default image when you
        // create the cell.
        NSDictionary *dataDict = weakSelf.dataArray[indexPath.row];
        [((HTKSampleCollectionViewCell *)cellToSetup) setupCellWithData:dataDict andImage:nil];
        
        // return cell
        return cellToSetup;

    }];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
