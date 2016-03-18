//
//  QFPKTabBarController.m
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFPKTabBarController.h"
#import "QFPKTabBarButton.h"

@interface QFPKTabBarController ()

@property (nonatomic, assign) BOOL      firstLoad;
@property (nonatomic, retain) UIView    *customizedTabBar;

@end

@implementation QFPKTabBarController


#pragma mark - Destructor


- (void)dealloc
{
    self.customizedTabBar = nil;
}


#pragma mark - Lifecycle Methods


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_firstLoad) {
        
        // 只能在这个方法里面写，要不self.viewControllers为空
        NSArray *tabBarBtns = self.tabBar.subviews;
        for (UIView *tabBarBtn in tabBarBtns) {
            tabBarBtn.hidden = YES;
        }
        
        CGFloat itemWidth = self.view.bounds.size.width / self.viewControllers.count;
        for (int i=0; i<self.viewControllers.count; i++) {
            
            UIViewController *vc = [self.viewControllers objectAtIndex:i];
            
            QFPKTabBarButton *tabBtn = [[QFPKTabBarButton alloc] initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth, 50) unselectedImage:vc.tabBarItem.image selectedImage:vc.tabBarItem.selectedImage title:vc.tabBarItem.title];
            tabBtn.tag = 100+i;
            [tabBtn setClickEventTarget:self action:@selector(tabBtnClick:)];
            
            [self.tabBar addSubview:tabBtn];
        }
        
        QFPKTabBarButton *selecedBtn = (QFPKTabBarButton *)[self.tabBar viewWithTag:self.selectedIndex+100];
        selecedBtn.selected = YES;
        
        _firstLoad = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstLoad = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Event Handlers


- (void)tabBtnClick:(QFPKTabBarButton *)btn
{
    // tabbar按钮点击的时候需要切换视图
    QFPKTabBarButton *currentSelectedBtn = (QFPKTabBarButton *)[self.tabBar viewWithTag:(self.selectedIndex + 100)];
    
    if (currentSelectedBtn != btn) {
        
        currentSelectedBtn.selected = NO;
        btn.selected = YES;
        
        self.selectedIndex = btn.tag - 100;
    }
}


#pragma mark - Screen Rotation


- (BOOL)shouldAutorotate
{
    return NO;
}


@end
