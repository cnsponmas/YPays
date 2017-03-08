//
//  YPayConfig.h
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>

//配置类型 目前只支持新浪、微信、腾讯
typedef NS_ENUM(NSInteger,YPayType)
{
    YPayType_AliPay,      //支付宝
    YPayType_WXPay,       //微信支付
    YPayType_UPPay,       //银联
};

typedef void (^YPayResultBlock)(YPayType type, id data);

@interface YPayConfig : NSObject

//应用注册scheme UP
@property (nonatomic, strong) NSString *YPayConfig_UPPay_AppScheme;

//应用注册scheme Ali
@property (nonatomic, strong) NSString *YPayConfig_AliPay_AppScheme;

//应用回调的 url Ali
@property (nonatomic, strong) NSString *YPayConfig_AliPay_OpenUrl;

//微信支付AppID
@property (nonatomic, strong) NSString *YPayConfig_WXPay_AppID;

//微信支付：应用描述
@property (nonatomic, strong) NSString *YPayConfig_WXPay_Description;

//应用注册scheme WX
@property (nonatomic, strong) NSString *YPayConfig_WXPay_AppScheme;


+ (YPayConfig *)config;

@end
