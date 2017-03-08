//
//  YPayAli.h
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPayConfig.h"

@interface YPayAli : NSObject

+ (void)startAliPayWithData:(id)payData
                  appScheme:(NSString *)appScheme
                 completion:(YPayResultBlock)completion;

+ (void)handlePaymentResultWithOpenURL:(NSURL *)url
                            completion:(YPayResultBlock)completion;

@end
