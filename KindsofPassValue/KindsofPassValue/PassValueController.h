//
//  PassValueController.h
//  KindsofPassValue
//
//  Created by  on 16/4/8.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol passValueDelegate <NSObject>
- (void)returnBackValue:(NSString *)backValue;
@end
@interface PassValueController : UIViewController
@property (nonatomic,assign) id<passValueDelegate>delegate;

#pragma mark --- 属性传值
@property (nonatomic,strong) NSString * propertyValue;
#pragma mark --- block传值
@property (nonatomic, copy) void(^returnBackValue)(NSString * backValue);
@end
