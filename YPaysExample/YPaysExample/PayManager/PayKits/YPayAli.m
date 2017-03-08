//
//  YPayAli.m
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "YPayAli.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation YPayAli

+ (void)handlePaymentResultWithOpenURL:(NSURL *)url
                            completion:(YPayResultBlock)completion{
    
    [[AlipaySDK defaultService]processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        completion(YPayType_AliPay,resultDic);
    }];
    
}

+ (void)startAliPayWithData:(id)payData
                  appScheme:(NSString *)appScheme
                 completion:(YPayResultBlock)completion{
    if (appScheme.length <=0 ) {
        NSLog(@"支付宝：传入参数有误");
    }
    [[AlipaySDK defaultService]payOrder:payData fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        completion(YPayType_AliPay,resultDic);
    }];
    
}


@end
