//
//  TestViewController.h
//  THCalendarDatePickerExample
//
//  Created by Hannes Tribus on 31/07/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

// 版权属于原作者
// http://code4app.com(cn) http://code4app.net(en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "BaseViewController.h"
#import "THDatePickerViewController.h"

@interface CalendarDatePickerViewController : BaseViewController<THDatePickerDelegate>
- (IBAction)touchedButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (nonatomic, strong) THDatePickerViewController * datePicker;

@end
