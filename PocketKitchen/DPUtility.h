//
//  DPUtility.h
//  PocketKitchen
//
//  Created by Tema on 15/5/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



#pragma mark - Definitions




/**
 如果字符串对象为空，返回空串 "", 如果不为空，则返回本身字符串
 */
#define EMPTY_STRING(str) (str ? str: @"")

/**
 屏幕大小
 */
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)



#pragma mark - NSObject (DPUtility)



/**
 NSObject的一些小工具
 */
@interface NSObject (DPUtility)

/**
 返回类的属性列表
 */
- (NSArray *)propertyList;

@end



#pragma mark - NSObject (DPUtility)



/**
 字符串的一些小工具
 */
@interface NSString (DPUtility)

/**
 返回一个新字符串，新字符串会去掉原字符串前后的空白字符
 */
- (NSString *)trimBlank;

/**
 返回字符串适合的Size
 */
- (CGSize)sizeToFitFont:(UIFont *)font max:(CGSize)maxSize;

/**
 返回经过MD5编码的字符串
 */
- (NSString *)md5String;

@end



#pragma mark - UIViewController (DPUtility)


/**
 ViewController的小些小工具
 */
@interface UIViewController (DPUtility)

+ (instancetype)instanceWithDefaultNib;

@end



#pragma mark - DPRemind



/**
 简单文字提示类，用于简单的文字提示
 */
@interface DPRemind : NSObject

/**
 简单提示一句文字
 */
+ (void)simpleRemindMessage:(NSString *)msg;

@end



#pragma mark - NSObject (DPUtility)



/**
 根据对象属性，动态生成dscription字符串，C函数
 */
NSString *ObjcDescription(id obj);

