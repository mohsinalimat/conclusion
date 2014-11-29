//
//  ViewController.m
//  testAliPay
//
//  Created by JSen on 14/9/29.
//  Copyright (c) 2014年 wifitong. All rights reserved.
//

#import "WxAliPayViewController.h"
#import "alipay/AlixPayOrder.h"
#import "AlixPayResult.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "DataVerifier.h"
#import "JSenPayEngine.h"


@interface WxAliPayViewController ()

- (IBAction)payAction:(UIButton *)sender;
- (IBAction)WXPayAction:(UIButton *)sender;

@end

@implementation WxAliPayViewController

#pragma mark - 微信支付


- (IBAction)WXPayAction:(UIButton *)sender {
   
    [[JSenPayEngine sharePayEngine] wxPayAction];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavigationView];
    [self loadRevealController];
    
    _result = @selector(paymentResult:);
    
 
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *aliPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aliPayButton.frame = CGRectMake(100, 100, DeviceWidth-200, 40);
    [aliPayButton setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [aliPayButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:aliPayButton];
    [aliPayButton addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *wxPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    wxPayButton.frame = CGRectMake(100, 200, DeviceWidth-200, 40);
    [wxPayButton setTitle:@"微信支付" forState:UIControlStateNormal];
    [wxPayButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:wxPayButton];
    [wxPayButton addTarget:self action:@selector(WXPayAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}

#pragma mark -
#pragma mark - 支付宝支付
- (void)paymentResult:(NSString *)resultd {
    AlixPayResult *result  = [[AlixPayResult alloc] initWithString:resultd];
    
    if (result) {
        
        if (result.statusCode == 9000) {
            NSString *key = AlipayPubKey;
            id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
            if ([verifier verifyString:result.resultString withSign:result.signString]) {
                NSLog(@"交易成功");
            }
        }else {
            NSLog(@"交易失败");
        }
        
    }else {
         NSLog(@"交易失败");
    }
    
}

- (void)testAliPay {
   
    
    NSString *orderId = [self generateTradeNO];
    
    NSDictionary *dict = @{
                           kOrderID:orderId,
                           kTotalAmount:@"0.01",
                           kProductDescription:@"3D打印VS无人机，谁在未来更赚钱？",
                           kProductName:@"自制白开水",
                           kNotifyURL:@"http://jifenmall.sinaapp.com/api/payment/alipay_notify"
                           };
    
    [JSenPayEngine paymentWithInfo:dict result:^(int statusCode, NSString *statusMessage, NSString *resultString, NSError *error, NSData *data) {
        NSLog(@"statusCode=%d \n statusMessage=%@ \n resultString=%@ \n err=%@ \n data=%@",statusCode,statusMessage,resultString,error,data);
    }];
}

- (IBAction)payAction:(UIButton *)sender {
    
    [self testAliPay];
  
  }


- (NSString *)generateTradeNO
{
    const int N = 15;
    
    NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *result = [[NSMutableString alloc] init] ;
    srand(time(0));
    for (int i = 0; i < N; i++)
    {
        unsigned index = rand() % [sourceString length];
        NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
        [result appendString:s];
    }
    return result;
}


@end
