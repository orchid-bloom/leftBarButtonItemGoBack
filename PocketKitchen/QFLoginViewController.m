//
//  QFLoginViewController.m
//  PocketKitchen
//
//  Created by Tema on 15/4/30.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFLoginViewController.h"
#import "QFPKUIFactory.h"
#import "QFRegisterViewController.h"
#import "QFPKNavigationController.h"
#import "QFLoginManager.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "GlobalDefine.h"
#import "AFNetworking.h"
#import "QFPKNetInterface.h"


@interface QFLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation QFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - Helper Methods


- (void)setupUI
{
    // 导航栏设置
    self.title = @"用户登录";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    UIBarButtonItem *spaceBBI = [QFPKUIFactory createSpaceBBIWithWidth:-15];
    UIBarButtonItem *backBBI = [QFPKUIFactory createBackBBIWithTarget:self action:@selector(backBBIDidClicked:)];
    self.navigationItem.leftBarButtonItems = @[spaceBBI, backBBI];
    
    // 注册按钮
    self.navigationItem.rightBarButtonItem = [QFPKUIFactory createTitleBBI:@"注册" target:self action:@selector(registerBBIClicked:)];
    
    // 背景颜色
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeview_bg"]];
}


#pragma mark - Events Handlers


- (void)registerBBIClicked:(id)sender
{
    // 创建注册的页面
    QFRegisterViewController *registerVC = [[QFRegisterViewController alloc] initWithNibName:@"QFRegisterViewController" bundle:nil];
    
    // 添加导航栏
    QFPKNavigationController *nav = [[QFPKNavigationController alloc] initWithRootViewController:registerVC];
    nav.navigationBar.barTintColor = [UIColor colorWithRed:254/255.0f green:120/255.0f blue:20/255.0f alpha:1.0f];
    
    // 使用模式跳转
    [self presentViewController:nav animated:YES completion:nil];
}

// 返回按钮的点击事件
- (void)backBBIDidClicked:(id)sender
{
    // 返回上一个界面
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)loginBtnDidClicked:(id)sender {
    
    [[QFLoginManager instance] loginWithID:self.userIDTextField.text
                                  password:self.passwordTextField.text
                                completion:^(QFLoginStatus status, QFUser *user) {
                                    
                                    // 如果登录成功，就返回上一个页面
                                    if (status == QFLoginStatusSuccessed) {
                                        
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                        [alert show];
                                        
                                        [self.navigationController popViewControllerAnimated:YES];
                                    }
                                }];
}

- (IBAction)qqLoginBtnClicked:(id)sender {
    
    [[QFLoginManager instance] qqLoginWithCompletion:^(QFLoginStatus status, QFUser *user) {
        // 如果登录成功，就返回上一个页面
        if (status == QFLoginStatusSuccessed) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
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
