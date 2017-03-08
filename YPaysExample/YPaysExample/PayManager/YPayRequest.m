//
//  YPayRequest.m
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "YPayRequest.h"
#import "YPayConfig.h"
#import "YPayWx.h"
#import "YPayAli.h"
#import "YPayUP.h"


@interface YPayRequest ()

@property (nonatomic, strong, readonly) YPayConfig *config;

@property(nonatomic, strong)YPayResultBlock resultBlock;

@end

@implementation YPayRequest

+ (instancetype)shareInstance
{
    static YPayRequest* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [YPayRequest new];
    });
    return instance;
}

+ (void)startPayWithType:(YPayType)payType
              controller:(UIViewController *)controller
                 payData:(id)data
              completion:(YPayResultBlock)completionBlock{
    [[self shareInstance] startPayWithType:payType controller:controller payData:data completion:completionBlock];
}

+ (void)handlePaymentResultWithOpenURL:(NSURL *)url withCompletion:(YPayResultBlock)completionBlock{
    NSString *hasString = [url absoluteString];
    if([hasString hasPrefix:[YPayConfig config].YPayConfig_UPPay_AppScheme]){
        [YPayUP handlePaymentResultWithOpenURL:url completion:[YPayRequest block]];
    }else if ([hasString hasPrefix:[YPayConfig config].YPayConfig_WXPay_AppScheme]){
        [YPayWx handlePaymentResultWithOpenURL:url completion:[YPayRequest block]];
    }
    if ([url.host isEqualToString:[YPayConfig config].YPayConfig_AliPay_OpenUrl]) {
        [YPayAli handlePaymentResultWithOpenURL:url completion:[YPayRequest block]];
    }
}

+ (YPayResultBlock )block{
    return [YPayRequest shareInstance].resultBlock;
}

- (void)startPayWithType:(YPayType)payType
              controller:(UIViewController *)controller
                 payData:(id)data
              completion:(YPayResultBlock)completionBlock{
    switch (payType) {
        case YPayType_UPPay:
        {
            [self startUPPay:data
                   appScheme:self.config.YPayConfig_UPPay_AppScheme
                  controller:controller
                  completion:completionBlock];
        }
            break;
        case YPayType_WXPay:
        {
            [self startWXPay:data completion:completionBlock];
        }
            break;
        case YPayType_AliPay:
        {
            [self startAliPay:data
                    appScheme:self.config.YPayConfig_AliPay_AppScheme
                   completion:completionBlock];
        }
            break;
        default:
            break;
    }
}

- (void)startWXPay:(id)data completion:(YPayResultBlock)completionBlock{
    if (![data isKindOfClass:[NSDictionary class]]) {
        NSLog(@"微信支付：传入参数有误");
        return;
    }
    _resultBlock = completionBlock;
    [YPayWx startWXPayWithData:data
                    completion:nil];
}

- (void)startUPPay:(id)data
         appScheme:(NSString *)appScheme
        controller:(UIViewController *)controller
        completion:(YPayResultBlock)completionBlock{
    
    if (![data isKindOfClass:[NSString class]]) {
        return;
    }
    _resultBlock = completionBlock;
    [YPayUP startUPPayWithTn:data
                   appScheme:appScheme
                        mode:@"01"
                  controller:controller
                  completion:nil];
}

- (void)startAliPay:(id)data
          appScheme:(NSString *)appScheme
         completion:(YPayResultBlock)completionBlock{
    
    if (![data isKindOfClass:[NSString class]]) {
        return;
    }
    _resultBlock = completionBlock;
    [YPayAli startAliPayWithData:data
                       appScheme:appScheme
                      completion:completionBlock];
}

- (YPayConfig *)config{
    return [YPayConfig config];
}


@end
