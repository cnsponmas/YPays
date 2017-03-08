//
//  YPayWx.h
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPayConfig.h"

@interface YPayWx : NSObject


/**
 注册微信api

 @param appid 在微信后台申请的appid
 @param description 描述
 */
+ (void)registerWxApp:(NSString *)appid description:(NSString *)description;

/**
 开始支付

 @param data 支付数据
 @param completion 回调
 */
+ (void)startWXPayWithData:(NSDictionary *)data  completion:(YPayResultBlock)completion;

/**
 支付结果处理

 @param url 支付数据
 @param completion 回调
 */
+ (void)handlePaymentResultWithOpenURL:(NSURL *)url
                            completion:(YPayResultBlock)completion;
@end
