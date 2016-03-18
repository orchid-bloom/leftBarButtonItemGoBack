//
//  QFSearchIntellegenceViewController.m
//  PocketKitchen
//
//  Created by Tema on 15/4/2.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFSearchIntellegenceViewController.h"

@interface QFSearchIntellegenceViewController ()

@end

@implementation QFSearchIntellegenceViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.navigationItem.title = @"智能选菜";
}

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
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.title = @"智能选菜";
}

@end
