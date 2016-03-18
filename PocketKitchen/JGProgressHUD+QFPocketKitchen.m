//
//  JGProgressHUD+QFPocketKitchen.m
//  PocketKitchen
//
//  Created by Tema on 15/5/20.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "JGProgressHUD+QFPocketKitchen.h"

@implementation JGProgressHUD (QFPocketKitchen)

+ (instancetype)showSimpleHUDWithText:(NSString *)text inView:(UIView *)view
{
    JGProgressHUD *hud = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    hud.textLabel.text = text;
    [hud showInView:view];
    
    return hud;
}

- (void)hides
{
    [self dismissAnimated:YES];
}

@end
