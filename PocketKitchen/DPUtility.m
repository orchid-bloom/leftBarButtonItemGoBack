//
//  DPUtility.m
//  PocketKitchen
//
//  Created by Tema on 15/5/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "DPUtility.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>



#pragma mark - NSObject (DPUtility)


@implementation NSObject (DPUtility)

/**
 返回类的属性列表
 */
- (NSArray *)propertyList
{
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:propertyCount];
    for (int i=0; i<propertyCount; i++) {
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
        [list addObject:propertyName];
    }
    free(properties);
    
    return [NSArray arrayWithArray:list];
}

@end


#pragma mark - NSString (DPUtility)


/**
 字符串的一些小工具
 */
@implementation NSString (DPUtility)

- (NSString *)trimBlank
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (CGSize)sizeToFitFont:(UIFont *)font max:(CGSize)maxSize
{
    
    return [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName: font}
                              context:nil].size;
}

- (NSString *)md5String
{
    const char *cStr = [self UTF8String];
    unsigned char buff[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), buff);
    
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i=0; i<16; i++) {
        [result appendFormat:@"%02x", buff[i]];
    }
    
    return result;
}


@end


#pragma mark - UIViewController (DPUtility)


@implementation UIViewController (DPUtility)

+ (instancetype)instanceWithDefaultNib
{
    NSString *nibName = [NSString stringWithUTF8String:class_getName([self class])];
    UIViewController *vc = [[self alloc] initWithNibName:nibName bundle:nil];
    
    return vc;
}

@end


#pragma mark - DPRemind


@implementation DPRemind

+ (void)simpleRemindMessage:(NSString *)msg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

@end


#pragma mark - C Fouction


/**
 根据对象属性，动态生成dscription字符串
 */
NSString *ObjcDescription(id obj)
{
    NSMutableString *descriptionStr = [NSMutableString stringWithFormat:@"<%s: %p; ", class_getName([obj class]), obj];
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([obj class], &propertyCount);
    for (int i=0; i<propertyCount; i++) {
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
        [descriptionStr appendFormat:@"%@ = %@; ", propertyName, [obj valueForKey:propertyName]];
    }
    free(properties);
    
    [descriptionStr deleteCharactersInRange:NSMakeRange(descriptionStr.length-2, 2)];
    [descriptionStr appendString:@">"];
    
    return [NSString stringWithString:descriptionStr];
}