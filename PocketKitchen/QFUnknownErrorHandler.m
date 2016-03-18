//
//  QFUnknownErrorHandler.m
//  PocketKitchen
//
//  Created by Tema on 15/3/16.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFUnknownErrorHandler.h"

@implementation QFUnknownErrorHandler


#pragma mark - Initialization Methods


+ (instancetype)handler
{
    static QFUnknownErrorHandler   *handler;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[[self class] alloc] init];
    });
    
    return handler;
}


#pragma mark - Setter & Getter


- (NSString *)errorDomain
{
    return @"";
}


#pragma mark - Interface Methods


- (void)handleError:(NSError *)error
{
    NSLog(@"Unknown Error:\n%@", error);
}

@end
