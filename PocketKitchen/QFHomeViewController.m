//
//  QFHomeViewController.m
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFHomeViewController.h"
#import "GlobalDefine.h"

@interface QFHomeViewController ()

@end

@implementation QFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self homeVCSetupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Helper Methods


/**
 页面初始的UI设置
 */
- (void)homeVCSetupUI
{
    // 设置导航栏的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:254/255.0f green:120/255.0f blue:20/255.0f alpha:1.0f];
    
    // 设置页面左上角的标题
    self.navigationItem.leftBarButtonItems = @[[QFPKUIFactory createSpaceBBIWithWidth:-10], [QFPKUIFactory createProjectTitleBBI]];
    
    // 背景颜色
    self.view.backgroundColor = [QFPKUIFactory createVCBackgroundColor];
}

@end
