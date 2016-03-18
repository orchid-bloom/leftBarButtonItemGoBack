//
//  QFPKUIFactory.h
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 这是一个UI工厂，用来生产多次重复出现的UI控件
 */
@interface QFPKUIFactory : NSObject


#pragma mark - Create BBI


/**
 创建首页上的标题的BBI
 */
+ (UIBarButtonItem *)createProjectTitleBBI;


/**
 创建用来调整BBI位置的一个占位BBI
 
 @param width 这个宽度就是你要调整的宽度，可以为负数，负数向反方向调整
 */
+ (UIBarButtonItem *)createSpaceBBIWithWidth:(CGFloat)width;


/**
 创建应用返回BBI
 
 @param target 事件的目标对象
 @param action 事件的函数
 */
+ (UIBarButtonItem *)createBackBBIWithTarget:(id)target action:(SEL)action;


/**
 创建分割线的BBI
 */
+ (UIBarButtonItem *)createSplitLineBBI;


/**
 创建只带标题的BBI
 */
+ (UIBarButtonItem *)createTitleBBI:(NSString *)title target:(id)target action:(SEL)action;


/**
 创建掌厨通用的BBI
 */
+ (UIBarButtonItem *)createPKBBIWithTitle:(NSString *)title image:(UIImage *)image target:(id)tartget action:(SEL)selector;


#pragma mark - Other 


/**
 创建通用的背景颜色
 */
+ (UIColor *)createVCBackgroundColor;


/**
 创建整个应用的主题颜色
 */
+ (UIColor *)createThemeColor;

@end
