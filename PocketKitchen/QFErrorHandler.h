//
//  QFErrorHandler.h
//  PocketKitchen
//
//  Created by Tema on 15/3/15.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 错误的统一处理类，用于统一去处理应用的错误
 */
@interface QFErrorHandler : NSObject


@property (nonatomic, readonly) NSString        *errorDomain;
@property (nonatomic, readonly) QFErrorHandler  *nextHandler;


+ (instancetype)handler;

+ (void)handleError:(NSError *)error;
- (void)handleError:(NSError *)error;


@end
