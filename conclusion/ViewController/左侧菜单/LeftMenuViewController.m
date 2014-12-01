//
//  LeftMenuViewController.m
//  conclusion
//
//  Created by Laura on 14/11/29.
//  Copyright (c) 2014年 Laura. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "AppDelegate.h"
#import "AutoScrollViewController.h"
#import "MLNavigationController.h"
#import "CardViewController.h"
#import "CoreAnimationViewController.h"
#import "RefreshViewController.h"
#import "DoubleViewController.h"
#import "ThreeViewController.h"
#import "WxAliPayViewController.h"
#import "CalendarDatePickerViewController.h"
#import "ImageCropperViewController.h"
#import "TableViewTestViewController.h"
#import "ScrollTestViewController.h"
#import "CustomHeadViewController.h"
#import "SphereTagCloudViewController.h"
#import "PopSelectViewController.h"
#import "TextFieldResignFirstResponderViewController.h"
#import "LockFirstViewController.h"
#import "LockSecondViewController.h"
#import "TagCloudViewController.h"
#import "AutoResingCellViewController.h"


@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView ;
    NSArray *_dataArray;
    NSInteger _presentedRow;;
}
@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    [self loadNavigationView];
    [self setNavigationTitle:@"Imaginato"];
    _dataArray = @[@"ScrollView自动无限循环",@"类似FB和TW资料页",@"CoreAnimation可做百分比进度条-波浪效果",@"RefreshControl下拉上拉",@"多级的联系人列表",@"支付宝、微信支付",@"Scan QR Code",@"日期选择器",@"通过剪切图片作为头像",@"表格中下列时放大背景",@"3D旋转标签云",@"单选弹出视图",@"Input输入收回键盘",@"手势解锁",@"标签云",@"cell自动布局"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, DeviceWidth, DeviceHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource  =self;
    _tableView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoHomePage) name:@"GOTOHOMEPAGE" object:nil];
}

-(void)gotoHomePage{
    [self gotoPage:0];
}

-(void)setNavigationTitle:(NSString *)title
{
    CGSize expectSize = [title sizeWithFont:[UIFont fontWithName:DEFAULT_FONT_BOLD_NAME size:18]];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((DeviceWidth-60)/2-expectSize.width/2, 20+44/2-expectSize.height/2, expectSize.width, expectSize.height)];
    titleLabel.textColor = [ UIColor whiteColor];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:DEFAULT_FONT_BOLD_NAME size:18];
    [self.view addSubview:titleLabel];
}


#pragma mark tableview data  delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:18];
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    if (indexPath.row == 7) {
        UIImageView *qrImageView = [[UIImageView alloc]initWithFrame:CGRectMake(180, 6, 30 , 30)];
        qrImageView.image = [UIImage imageNamed:@"QR OK"];
        [cell.contentView addSubview:qrImageView];
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

#pragma mark tableview  delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    [self gotoPage:row];
    
}

-(void)gotoPage:(NSInteger)row{
    SWRevealViewController *revealController = self.revealViewController;
    UIViewController *newFrontController = nil;
    
    if(row == _presentedRow){
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }else{
        switch(row){
            case 0:
            {
                AutoScrollViewController *autoScrollViewController = [[AutoScrollViewController alloc]init];
                MLNavigationController *autoScrollNavigationController=[[MLNavigationController alloc] initWithRootViewController:autoScrollViewController];
                newFrontController = autoScrollNavigationController;
                break;
            }
            case 1:
            {
                CardViewController *cardViewController = [[CardViewController alloc]init];
                MLNavigationController *cardViewNavigationController=[[MLNavigationController alloc] initWithRootViewController:cardViewController];
                newFrontController = cardViewNavigationController;
                break;
            }
            case 2:
            {
                CoreAnimationViewController *coreAnimationViewController = [[CoreAnimationViewController alloc]init];
                MLNavigationController *coreAnimationNavigationController=[[MLNavigationController alloc] initWithRootViewController:coreAnimationViewController];
                newFrontController = coreAnimationNavigationController;
                break;
            }
            case 3:
            {
                RefreshViewController *refreshViewController = [[RefreshViewController alloc]init];
                MLNavigationController *refreshNavigationController=[[MLNavigationController alloc] initWithRootViewController:refreshViewController];
                newFrontController = refreshNavigationController;
                break;
            }
            case 4:
            {
                DoubleViewController *viewController1;
                ThreeViewController *viewController2;
                viewController1 = [[DoubleViewController alloc] initWithNibName:nil bundle:nil];
                viewController1.title = @"二级联系人列表";
                viewController2 = [[ThreeViewController alloc] initWithNibName:nil bundle:nil];
                viewController2.title = @"三级联系人列表";
                UITabBarController *tabBarController = [[UITabBarController alloc] init];
                tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, nil];
                newFrontController = tabBarController;
                break;
            }
            case 5:
            {
                WxAliPayViewController *wxAliPayViewController = [[WxAliPayViewController alloc]init];
                MLNavigationController *wxAliPayNavigationController=[[MLNavigationController alloc] initWithRootViewController:wxAliPayViewController];
                newFrontController = wxAliPayNavigationController;
                break;
            }
                
            case 6:
            {
                break;
            }
                
            case 7:
            {
                CalendarDatePickerViewController *calendarDatePickerViewController = [[CalendarDatePickerViewController alloc]init];
                MLNavigationController *calendarDatePickerNavigationController=[[MLNavigationController alloc] initWithRootViewController:calendarDatePickerViewController];
                newFrontController = calendarDatePickerNavigationController;
            }
                break;
            case 8:
            {
                ImageCropperViewController *imageCropperViewController = [[ImageCropperViewController alloc]init];
                MLNavigationController *imageCropperNavigationController=[[MLNavigationController alloc] initWithRootViewController:imageCropperViewController];
                newFrontController = imageCropperNavigationController;
                
                break;
            }
                
            case 9:
            {
                TableViewTestViewController *viewController1;
                ScrollTestViewController *viewController2;
                CustomHeadViewController *viewController3;
                viewController1 = [[TableViewTestViewController alloc] initWithNibName:nil bundle:nil];
                viewController1.title = @"TableView";
                viewController2 = [[ScrollTestViewController alloc] initWithNibName:nil bundle:nil];
                viewController2.title = @"ScrollView";
                viewController3 = [[CustomHeadViewController alloc]initWithNibName:nil bundle:nil];
                viewController3.title = @"CustomHeadView";
                UITabBarController *tabBarController = [[UITabBarController alloc] init];
                tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2,viewController3, nil];
                newFrontController = tabBarController;
                
                break;
            }
                
            case 10:
            {
                SphereTagCloudViewController *sphereTagCloudViewController = [[SphereTagCloudViewController alloc]init];
                MLNavigationController *sphereTagCloudNavigationController=[[MLNavigationController alloc] initWithRootViewController:sphereTagCloudViewController];
                newFrontController = sphereTagCloudNavigationController;
                
                break;
            }
            case 11:
            {
                PopSelectViewController *popSelectViewController = [[PopSelectViewController alloc]init];
                MLNavigationController *popSelectNavigationController=[[MLNavigationController alloc] initWithRootViewController:popSelectViewController];
                newFrontController = popSelectNavigationController;
                
                break;
            }
            case 12:
            {
                TextFieldResignFirstResponderViewController *textFieldResignFirstResponderViewController = [[TextFieldResignFirstResponderViewController alloc]init];
                MLNavigationController *textFieldResignFirstResponderNavigationController=[[MLNavigationController alloc] initWithRootViewController:textFieldResignFirstResponderViewController];
                newFrontController = textFieldResignFirstResponderNavigationController;
                
                break;
            }
            case 13:
            {
                LockFirstViewController *viewController1;
                LockSecondViewController *viewController2;
                viewController1 = [[LockFirstViewController alloc] initWithNibName:nil bundle:nil];
                viewController1.title = @"首页";
                viewController2 = [[LockSecondViewController alloc] initWithNibName:nil bundle:nil];
                viewController2.title = @"设置";
                UITabBarController *tabBarController = [[UITabBarController alloc] init];
                tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, nil];
                newFrontController = tabBarController;
                
                // 手势解锁相关
                NSString* pswd = [LLLockPassword loadLockPassword];
                if (pswd) {
                    [[AppDelegate ShareApp] showLLLockViewController:LLLockViewTypeCheck];
                } else {
                    [[AppDelegate ShareApp] showLLLockViewController:LLLockViewTypeCreate];
                }
    
                
                break;
            }
            case 14:
            {
                TagCloudViewController *tagCloudViewController = [[TagCloudViewController alloc]init];
                MLNavigationController *tagCloudNavigationController=[[MLNavigationController alloc] initWithRootViewController:tagCloudViewController];
                newFrontController = tagCloudNavigationController;
                
                
                break;
            }
            case 15:
            {
                AutoResingCellViewController *autoResingCellViewController = [[AutoResingCellViewController alloc]init];
                MLNavigationController *autoResingCellNavigationController=[[MLNavigationController alloc] initWithRootViewController:autoResingCellViewController];
                newFrontController = autoResingCellNavigationController;
                
                
                break;
            }
            default:
                break;
        }
        
    }
    [self.revealViewController setFrontViewController:newFrontController animated:NO];
    [self.revealViewController revealToggleAnimated:YES];
    
    _presentedRow = row;
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
