//
//  QFRegisterViewController.m
//  PocketKitchen
//
//  Created by Tema on 15/4/30.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFRegisterViewController.h"
#import "QFPKUIFactory.h"
#import "AFNetworking.h"
#import "GlobalDefine.h"

@interface QFRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ensurePasswordTextField;

@end

@implementation QFRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Helper Methods


- (void)setupUI
{
    self.title = @"用户注册";
    
    // title的样式
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor whiteColor]};;
    
    // 返回的BBI
    UIBarButtonItem *spaceBBI = [QFPKUIFactory createSpaceBBIWithWidth:-15];
    UIBarButtonItem *backBBI = [QFPKUIFactory createBackBBIWithTarget:self action:@selector(backBBIClicked:)];
    self.navigationItem.leftBarButtonItems = @[spaceBBI, backBBI];
    
    // 当前页面的背景颜色
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeview_bg"]];
}


#pragma mark - Event Handlers


- (void)backBBIClicked:(id)sender
{
    // 返回到登录界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerBtnDidClicked:(id)sender {
    
    NSLog(@"%@", self.accountTextField.text);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://admin.izhangchu.com:80/HandHeldKitchenCommunity/api/user/users!register.do" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 账号
        [formData appendPartWithFormData:[self.accountTextField.text dataUsingEncoding:NSUTF8StringEncoding] name:@"loginName"];
        NSLog(@"loginName:%@",self.accountTextField.text);
        
        // 昵称
        [formData appendPartWithFormData:[self.nickNameTextField.text dataUsingEncoding:NSUTF8StringEncoding] name:@"userName"];
        NSLog(@"userName:%@",self.nickNameTextField.text);
        
        // 密码
        NSString *md5Password = [self.passwordTextField.text md5String];
        
        [formData appendPartWithFormData:[md5Password dataUsingEncoding:NSUTF8StringEncoding] name:@"password"];
        NSLog(@"password:%@",md5Password);
        
        // 密码明文
        [formData appendPartWithFormData:[self.passwordTextField.text dataUsingEncoding:NSUTF8StringEncoding] name:@"md5"];
        NSLog(@"md5:%@",self.passwordTextField.text);
        
        // 固定值，写死
        [formData appendPartWithFormData:[@"0" dataUsingEncoding:NSUTF8StringEncoding] name:@"is_traditional"];
        
        // 手机号
        [formData appendPartWithFormData:[self.accountTextField.text dataUsingEncoding:NSUTF8StringEncoding] name:@"phone"];
        
        // 固定值，写死
        [formData appendPartWithFormData:[@"App Store" dataUsingEncoding:NSUTF8StringEncoding] name:@"channel"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject[@"message"]);
        //[DPRemind simpleRemindMessage:responseObject[@"message"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
