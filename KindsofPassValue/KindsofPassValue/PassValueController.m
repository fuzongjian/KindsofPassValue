//
//  PassValueController.m
//  KindsofPassValue
//
//  Created by on 16/4/8.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "PassValueController.h"
#import "SingletonManager.h"
#import "AppDelegate.h"
#define NSNotification_KEY @"NSNotification_KEY"
#define NSNotificationName @"NSNotificationName"
@interface PassValueController ()
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@end

@implementation PassValueController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)back:(id)sender {
    
//    通知广播发射消息
    NSDictionary * dic = [NSDictionary dictionaryWithObject:_textFiled.text forKey:NSNotification_KEY];
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName object:dic];
    
//    代理回调传值
    if ([self.delegate conformsToProtocol:@protocol(passValueDelegate)] && [self.delegate respondsToSelector:@selector(returnBackValue:)]) {
         [self.delegate returnBackValue:_textFiled.text];
    }
    
//    block回调传值
    if (self.returnBackValue) {
        self.returnBackValue(_textFiled.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
#pragma mark --- 属性传值
    NSLog(@"%@",self.propertyValue);
#pragma mark --- NSUserDefaults传值
     NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"NSUserDefaults"]);
#pragma mark --- 单例传值
    SingletonManager * manager = [SingletonManager defalutManager];
     NSLog(@"%@",manager.singletonValue);
#pragma mark --- UIApplication传值
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
     NSLog(@"%@",app.AppDelegateValue);
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textFiled resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
