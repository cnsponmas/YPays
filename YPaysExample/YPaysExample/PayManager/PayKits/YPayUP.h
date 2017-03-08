//
//  YPayUP.h
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YPayConfig.h"

@interface YPayUP : NSObject

/**
 开始支付

 @param tn 订单号
 @param appScheme urltyps
 @param mode 模式：生产、测试
 @param controller 调起支付的controller
 @param completion 回调
 */
+ (void)startUPPayWithTn:(NSString *)tn
               appScheme:(NSString *)appScheme
                    mode:(NSString *)mode
              controller:(UIViewController *)controller
              completion:(YPayResultBlock)completion;


/**
 处理钱包或者独立快捷app支付跳回商户app携带的支付结果Url
 
 @param url 支付结果Url
 */
+ (void)handlePaymentResultWithOpenURL:(NSURL *)url
                            completion:(YPayResultBlock)completion;

@end
