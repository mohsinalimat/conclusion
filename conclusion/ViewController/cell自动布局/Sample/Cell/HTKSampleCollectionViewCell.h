//
//  HTKSampleCollectionViewCell.h
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


#import <UIKit/UIKit.h>
#import "HTKDynamicResizingCollectionViewCell.h"
#import "HTKDynamicResizingCellProtocol.h"

/**
 * Default cell size. This is required to properly size cells.
 */
#define DEFAULT_CELL_SIZE (CGSize){[[UIScreen mainScreen] bounds].size.width, 85}

/**
 * Sample CollectionViewCell that implements the dynamic sizing protocol.
 */
@interface HTKSampleCollectionViewCell : HTKDynamicResizingCollectionViewCell

/**
 * Sets up the cell with data
 */
- (void)setupCellWithData:(NSDictionary *)data andImage:(UIImage *)image;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
