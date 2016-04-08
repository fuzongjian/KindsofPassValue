//
//  SingletonManager.h
//  KindsofPassValue
//
//  Created by  on 16/4/8.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonManager : NSObject
+ (instancetype)defalutManager;
#pragma mark --- 单例一般都是利用属性数值，比较简单
@property (nonatomic,strong) NSString * singletonValue;
@end
