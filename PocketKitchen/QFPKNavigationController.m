//
//  QFPKNavigationController.m
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFPKNavigationController.h"

@interface QFPKNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation QFPKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 更新状态栏风格，这种写法，如果有NavigationController一定要在NavigationController里面设置
    [self setNeedsStatusBarAppearanceUpdate];
    
    // 启用返回手势需要添加这个手势delegate属性
    self.interactivePopGestureRecognizer.delegate = self;
    
    // 设置标题颜色，标题的字体
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:21]};
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Status Bar Style


/**
 返回状态栏风格
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - Override



// 在手势的代理函数这里判断，是否要启用手势，返回YES就是启用，返回NO就是禁用
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    
    return YES;
}


#if 0   // 这种方式会出问题

/**
 重写这个方法来启用返回手势
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    self.interactivePopGestureRecognizer.enabled = YES;
}


/**
 重写这个方法来判断启用和禁用返回手势
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc = [super popViewControllerAnimated:animated];    
    
    // iOS7返回手势的启用和禁用
    if (self.viewControllers.count > 0) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    else {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return vc;
}

#endif


@end
