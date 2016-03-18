//
//  JGProgressHUD+QFPocketKitchen.h
//  PocketKitchen
//
//  Created by Tema on 15/5/20.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "JGProgressHUD.h"


/**
 针对这个项目，对JGP的简单的封装
 */
@interface JGProgressHUD (QFPocketKitchen)

/**
 显示HUD
 */
+ (instancetype)showSimpleHUDWithText:(NSString *)text inView:(UIView *)view;


/**
 隐藏HUD
 */
- (void)hides;

@end
