//
//  YPayWx.m
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "YPayWx.h"
#import "WXApi.h"

@interface YPayWx ()<WXApiDelegate>

@property (nonatomic, strong)YPayResultBlock payBlock;

@end

@implementation YPayWx

+ (instancetype)shareInstance{
    static YPayWx* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [YPayWx new];
    });
    return instance;
}

+ (void)registerWxApp:(NSString *)appid
          description:(NSString *)description{
    BOOL flag = [WXApi registerApp:appid withDescription:description];
    if (!flag) {
        NSLog(@"微信api注册失败");
    }
}

+ (void)startWXPayWithData:(NSDictionary *)data
                completion:(YPayResultBlock)completion{
    
    NSString *partnerId = [data objectForKey:@"partnerid"];
    NSString *prepayId = [data objectForKey:@"prepayid"];
    NSString *package = [data objectForKey:@"package"];
    NSString *nonceStr = [data objectForKey:@"noncestr"];
    int timeStamp= [[data objectForKey:@"timestamp"] intValue];
    NSString *sign= [data objectForKey:@"sign"];
    
    if (!partnerId||!prepayId||!package||!nonceStr||!timeStamp||!sign) {
        NSDictionary *dic = @{@"resCode":@"failed", @"resData":@"wxapi 传入参数错误"};
        completion(YPayType_WXPay,dic);
        return;
    }
    
    PayReq *request = [[PayReq alloc]init];
    request.partnerId = partnerId;
    request.prepayId= prepayId;
    request.package = package;
    request.nonceStr= nonceStr;
    request.timeStamp= timeStamp;
    request.sign= sign;
    
    if (![WXApi sendReq:request]) {
        NSDictionary *dic = @{@"resCode":@"failed", @"resData":@"wxapi调起失败"};
        completion(YPayType_WXPay,dic);
    }
}

+ (void)handlePaymentResultWithOpenURL:(NSURL *)url completion:(YPayResultBlock)completion{
    [[YPayWx shareInstance] handlePaymentResultWithOpenURL:url completion:completion];
}

- (void)handlePaymentResultWithOpenURL:(NSURL *)url completion:(YPayResultBlock)completion{
    _payBlock = completion;
    [WXApi handleOpenURL:url delegate:self];
}

- (void)onResp:(BaseResp *)resp{
    NSString *code = @"";
    NSString *str = @"";
    if(!resp.errStr){
        str = @"未知错误";
    }else{
        str = resp.errStr;
    }
    if (!resp.errCode) {
        code = @"unknow";
    }else{
        code = [NSString stringWithFormat:@"%d",resp.errCode];
    }
    NSDictionary *dic = @{@"resCode":code, @"resData":str};
    
    _payBlock(YPayType_WXPay,dic);
}


@end
