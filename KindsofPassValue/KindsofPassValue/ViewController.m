//
//  ViewController.m
//  KindsofPassValue
//
//  Created by on 16/4/8.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "ViewController.h"
#import "PassValueController.h"
#import "SingletonManager.h"
#import "AppDelegate.h"
#define NSNotificationName @"NSNotificationName"
#define NSNotification_KEY @"NSNotification_KEY"
@interface ViewController ()<passValueDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNSNotificationCenter];
    
/**
 *  下面的三种方式实质都是单例传值
 */
#pragma mark --- 自定义一个单例
    SingletonManager * manager = [SingletonManager defalutManager];
    manager.singletonValue = @"我是单例传过来的值";
#pragma mark --- NSUserDefaults也是一个单例，只能小规模传值
/**
    NSUserDefaults可以存储NSString,NSNumber, NSDate, NSArray, NSDictionary，自定义类可以通过NSData的方式进行存储，当然要实现NSCoding这个protocol才行，NSObject<NSCoding>
    如果系统以外闪退，数据可能不会被写入，所以我们需要实现synchronize方法，来实现数据的同步，数据会被写入系统的/Library/Preferences/gongcheng.plist文件中
 */
    [[NSUserDefaults standardUserDefaults] setObject:@"我是NSUserDefaults传过来的值" forKey:@"NSUserDefaults"];
    [[NSUserDefaults standardUserDefaults] synchronize];
#pragma mark --- UIApplication传值 我在Appdelegate里面定义了一个属性 AppDelegateValue
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    app.AppDelegateValue = @"我是UIApplication传过来的值";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"trans"]) {
        PassValueController * passvalue = segue.destinationViewController;
        
#pragma mark --- 属性传值  在PassValueController.h定义一个属性
/**
 *  @brief 属性传值一般多用于前一个界面向后一个界面传值
 */
        passvalue.propertyValue = @"我们是通过属性传过来的值";
#pragma mark --- 拿到代理
        passvalue.delegate = self;
#pragma mark --- block回调
/**
    @brief 多用于后一个界面向前一个界面传值
    block运用的最主要的注意点循环引用问题，block内按照下面方式写就可以了
    __weak __typeof(self) weakSelf = self;
    __weak __typeof(<#实例变量#>) <#更换后的名称#> = <#实例变量#>;
 */
        passvalue.returnBackValue = ^(NSString * backValue){
             NSLog(@"我们是通过block回调传过来的值--%@",backValue);
        };
    }
}
#pragma mark --- 代理传值回调
/**
    代理传值需要消息的界面需要遵循协议，然后实现协议的方法即可
 */
-(void)returnBackValue:(NSString *)backValue{
     NSLog(@"我们是通过代理回调穿过来的值--%@",backValue);
}
#pragma mark --- 消息中心的注册及销毁
/**
    通知传值的方式就类似我们广播， 
    第一、广播基站需要建设——————我们的消息中需要注册
    第二、众所周知只有我们知道了广播的频段我们才能接受这个广播基站发送的消息——————我们的消息接收者需要知道我们消息的名字才能接收
    第三、广播基站发送消息——————我们的消息中心发送通知，通知内容存放在字典模型中
    第四、听众通过收音机听广播——————消息接受者通过解析数据获得消息
    第五、听众不听广播需要关闭收音机——————消息中心的销毁
    注意：需要消息的界面需要注册通知
 */
- (void)registerNSNotificationCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotificationCenterNotity:) name:NSNotificationName object:nil];
}
- (void)NSNotificationCenterNotity:(NSNotification *)notify{
    NSDictionary * dic = notify.object;
    NSLog(@"我们是消息中心传过来的值--%@",[dic objectForKey:NSNotification_KEY]);
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNotificationName object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//      [NSUserDefaults standardUserDefaults] 1
//    NSNotificationCenter 2
//    Block 3
//    property 4
//    Delegate 5
//    Singleton 6
//    sharedApplication
    // Dispose of any resources that can be recreated.
}

@end
