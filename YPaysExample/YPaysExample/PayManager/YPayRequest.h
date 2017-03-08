//
//  YPayRequest.h
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YPayConfig.h"

@interface YPayRequest : NSObject


/**
 调起支付

 @param payType 支付类型
 @param controller 调起的controller
 @param data 支付数据
 @param completionBlock 回调
 */
+ (void)startPayWithType:(YPayType)payType
              controller:(UIViewController *)controller
                 payData:(id)data
              completion:(YPayResultBlock)completionBlock;


/**
 支付结果处理

 @param url 结果数据
 @param completionBlock 回调
 */
+ (void)handlePaymentResultWithOpenURL:(NSURL *)url
                        withCompletion:(YPayResultBlock)completionBlock;

@end
