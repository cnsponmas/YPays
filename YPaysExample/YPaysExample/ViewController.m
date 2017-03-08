//
//  ViewController.m
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "ViewController.h"
#import "YPay.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array = @[@"银联支付测试",@"支付宝支付测试",@"微信支付测试"];
    UITableView * _poiTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _poiTableView.dataSource = self;
    _poiTableView.delegate = self;
    _poiTableView.backgroundView = nil;
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_poiTableView setTableFooterView:view];
    
    [self.view addSubview:_poiTableView];

    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"123123";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier ];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            //http://101.231.204.84:8091/sim/getacptn 访问这个可以拿到银联的测试订单
            [YPayRequest startPayWithType:YPayType_UPPay controller:self payData:@"899395104446168675701" completion:^(YPayType type, id data) {
                NSLog(@"%@",data);
            }];
            break;
        case 1:
            //订单信息需要服务器去生成
            [YPayRequest startPayWithType:YPayType_AliPay controller:self payData:@"app_id=2017011905222592&biz_content=%7B%22body%22%3A%22java%E5%90%8E%E5%8F%B0%E8%BF%94%E5%9B%9E%E6%95%B0%E6%8D%AE%22%2C%22out_trade_no%22%3A%22201702000024%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22subject%22%3A%22%E8%90%9D%E5%8D%9C%E7%BD%91%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%220.01%22%7D&charset=utf-8&method=alipay.trade.app.pay&notify_url=http%3A%2F%2F118.242.32.250%3A9988%2Fty-war%2FmobileAlipay%2FpayNotify&sign_type=RSA2&timestamp=2017-03-08+17%3A24%3A56&version=1.0&sign=6aVQKce2mMGjOAzQryt%2BZ2tKZhncW2dm4kAnCX%2FJRMPwM91BxPhxVZi%2Bq11A%2BuIga1HOyIio7dJYekkdobiuPnexMVyJITCl9ilvQSZtrvezXFSOkTrKPx0BI3zRnKZRoSnN0B6yDzuOsHx1UVeQmaLc7lBJWO05xdzTDGnVKN1KLFGPZM7420toMtVhDuAVSMLiOxQudUt71CMjA8hRaq1gBG%2BrfEEtZo94Q0CzPjfXUfa7%2B%2FpjrQOOKdpuYV30AyZ3Pv0tIZ00K%2Fy0Pk1F9dnkp7nuVGInl3RwX8%2BgqG5La5r7bTZlAy%2FJQjw4bcJHgE%2F78x%2FPxd1a8CU6eYP%2FuA%3D%3D" completion:^(YPayType type, id data) {
            }];
            break;
        case 2:
            [YPayRequest startPayWithType:YPayType_WXPay controller:self payData:@{} completion:^(YPayType type, id data) {
            }];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
