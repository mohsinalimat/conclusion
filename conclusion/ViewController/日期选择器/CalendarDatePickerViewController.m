//
//  TestViewController.m
//  THCalendarDatePickerExample
//
//  Created by Hannes Tribus on 31/07/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

// 版权属于原作者
// http://code4app.com(cn) http://code4app.net(en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "CalendarDatePickerViewController.h"

@interface CalendarDatePickerViewController ()
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
@end

@implementation CalendarDatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNavigationView];
    [self loadRevealController];
    
    
    self.dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dateButton.frame = CGRectMake(100, 100, DeviceWidth-200, 40);
    [self.dateButton addTarget:self action:@selector(touchedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.dateButton];
    
    self.curDate = [NSDate date];
    
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"dd/MM/yyyy --- HH:mm"];
    [self refreshTitle];
}

-(void)refreshTitle{
    if(self.curDate) {
        [self.dateButton setTitle:[_formatter stringFromDate:_curDate] forState:UIControlStateNormal];
    }
    else {
        [self.dateButton setTitle:@"No date selected" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchedButton:(id)sender {
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    self.datePicker.date = self.curDate;
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setAutoCloseOnSelectDate:YES];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];

    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
     int tmp = (arc4random() % 30)+1;
     if(tmp % 5 == 0)
     return YES;
     return NO;
     }];
    //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(1.0),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];
}

-(void)datePickerDonePressed:(THDatePickerViewController *)datePicker{
    self.curDate = datePicker.date;
    [self refreshTitle];
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

-(void)datePickerCancelPressed:(THDatePickerViewController *)datePicker{
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}


@end
