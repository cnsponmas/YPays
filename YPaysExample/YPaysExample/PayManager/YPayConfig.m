//
//  YPayConfig.m
//  YPaysExample
//
//  Created by yanzoro on 17/3/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "YPayConfig.h"

@implementation YPayConfig

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (YPayConfig *)config {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
