//
//  YPayUP.m
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "YPayUP.h"
#import "UPPaymentControl.h"

@implementation YPayUP

+ (void)startUPPayWithTn:(NSString *)tn
               appScheme:(NSString *)appScheme
                    mode:(NSString *)mode
              controller:(UIViewController *)controller
              completion:(YPayResultBlock)completion{
    if (appScheme.length <=0 || !controller || mode.length <=0) {
        NSLog(@"银联支付：传入参数有误");
    }
    
    BOOL flag = NO;
    if (tn != nil && tn.length > 0 && controller)
    {
        if (mode.length <=0) {
            mode = @"01";
        }
        flag =  [[UPPaymentControl defaultControl] startPay:tn fromScheme:appScheme mode:mode viewController:controller];
    }
    
    if (!flag) {
        NSDictionary *dic = @{@"resCode":@"failed", @"resData":@"upapi调起失败"};
        if (completion) {
            completion(YPayType_UPPay,dic);
        }
    }
}

+ (void)handlePaymentResultWithOpenURL:(NSURL *)url completion:(YPayResultBlock)completion{
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        if (code) {
            [dic setObject:code forKey:@"resCode"];
        }
        if(data){
            [dic setObject:data forKey:@"resData"];
        }

        completion(YPayType_UPPay,dic);
    }];

}

@end
