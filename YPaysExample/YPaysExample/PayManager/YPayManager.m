//
//  YPayManager.m
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "YPayManager.h"
#import "YPayUP.h"
#import "YPayAli.h"
#import "YPayWx.h"

#define YPayInstance [YPayManager sharePay]


@interface YPayManager ()
@property (nonatomic, strong, readonly) YPayConfig *config;

@end

@implementation YPayManager

+ (YPayManager *)sharePay{
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return  shareInstance;
}

+ (void)setupConfig:(void (^)(YPayConfig *))configBlock{
    [YPayInstance setupConfig:configBlock];
    [YPayManager initPayConfig];
}

+ (void)initPayConfig{
    [YPayInstance initPayConfig];
}

- (void)setupConfig:(void (^)(YPayConfig *))configBlock{
    if (self.config) {
        configBlock(self.config);
    }
}

- (void)initPayConfig{
    [self initWXPay:self.config.YPayConfig_WXPay_AppID
        description:self.config.YPayConfig_WXPay_Description];
}

- (YPayConfig *)config{
    return [YPayConfig config];
}

- (void)initUPPay:(NSString *)appScheme{
    
}

- (void)initAliPay:(NSString *)appID
         appScheme:(NSString *)appScheme
           openUrl:(NSString *)openUrl{
    
}

- (void)initWXPay:(NSString *)appID
      description:(NSString *)description{
    [YPayWx registerWxApp:appID description:description];
}

@end
