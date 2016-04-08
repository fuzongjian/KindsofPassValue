//
//  SingletonManager.m
//  KindsofPassValue
//
//  Created by  on 16/4/8.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "SingletonManager.h"

@implementation SingletonManager
+ (instancetype)defalutManager{
    static SingletonManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SingletonManager alloc] init];
    });
    return manager;
}
@end
