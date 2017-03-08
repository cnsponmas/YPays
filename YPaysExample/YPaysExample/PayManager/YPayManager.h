//
//  YPayManager.h
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPayConfig.h"

@interface YPayManager : NSObject

/**
 配置支付信息

 @param configBlock 配置文件
 */
+ (void)setupConfig:(void(^)(YPayConfig *config))configBlock;

@end
