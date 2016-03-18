//
//  AppDelegate.m
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "AppDelegate.h"
#import "QFPKNavigationController.h"
#import "QFPKTabBarController.h"
#import "QFCookbookViewController.h"
#import "QFExploreViewController.h"
#import "QFPlazaViewController.h"
#import "QFAboutMeViewController.h"
#import "QFGuideViewController.h"
#import "QFErrorHandlerManager.h"
#import "GlobalDefine.h"


@interface AppDelegate () <QFGuideDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 初始化错误处理器
    [QFErrorHandlerManager configurationHandlers];
    
    // 初始化数据库
    [QFCoreDataDocumentManager manager];
    
    // 加载根视图
    [self loadRootViewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - Helper Method


/**
 加载应用的根视图，在这里判断是加载引导页的界面还是加载主页面
 */
- (void)loadRootViewController
{
    self.window.rootViewController = [self createTabBarController];
}

/**
 创建TabBarController，并设置TabBar的标题，和图标
 */
- (UITabBarController *)createTabBarController
{
    // 初始化四个主视图
    QFCookbookViewController *cookbookVC = [[QFCookbookViewController alloc] initWithNibName:@"QFCookbookViewController" bundle:nil];
    QFExploreViewController *exploreVC = [[QFExploreViewController alloc] initWithNibName:@"QFExploreViewController" bundle:nil];
    QFPlazaViewController *plazaVC = [[QFPlazaViewController alloc] initWithNibName:@"QFPlazaViewController" bundle:nil];
    QFAboutMeViewController *aboutMeVC = [[QFAboutMeViewController alloc] initWithNibName:@"QFAboutMeViewController" bundle:nil];
    
    // 初始化对应的导航栏
    QFPKNavigationController *cookbookNav = [[QFPKNavigationController alloc] initWithRootViewController:cookbookVC];
    QFPKNavigationController *exploreNav = [[QFPKNavigationController alloc] initWithRootViewController:exploreVC];
    QFPKNavigationController *plazaNav = [[QFPKNavigationController alloc] initWithRootViewController:plazaVC];
    QFPKNavigationController *aboutMeNav = [[QFPKNavigationController alloc] initWithRootViewController:aboutMeVC];
    
    // 设置TabBar上对应标题
    cookbookNav.tabBarItem.title = @"菜谱";
    exploreNav.tabBarItem.title = @"发现";
    plazaNav.tabBarItem.title = @"广场";
    aboutMeNav.tabBarItem.title = @"我的";
    
    // 设置TabBar上对应的icon
    cookbookNav.tabBarItem.image = [UIImage imageNamed:@"tab_cookbook"];
    cookbookNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_cookbook_hl"];
    
    exploreNav.tabBarItem.image = [UIImage imageNamed:@"tab_explore"];
    exploreNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_explore_hl"];
    
    plazaNav.tabBarItem.image = [UIImage imageNamed:@"tab_plaza"];
    plazaNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_plaza_hl"];
    
    aboutMeNav.tabBarItem.image = [UIImage imageNamed:@"tab_aboutme"];
    aboutMeNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_aboutme_hl"];
    
    
    // 用设置好的四个视图来初始化TabBarController
    QFPKTabBarController *tabBarController = [[QFPKTabBarController alloc] init];
    tabBarController.viewControllers = @[cookbookNav, exploreNav, plazaNav, aboutMeNav];
    
    return tabBarController;
}


#pragma mark - QFGuideDelegate


- (void)guideDidFinished
{
    
}

@end
