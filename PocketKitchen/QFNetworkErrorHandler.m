//
//  QFNetworkErrorHandler.m
//  PocketKitchen
//
//  Created by Tema on 15/3/15.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFNetworkErrorHandler.h"
#import "GlobalDefine.h"

@implementation QFNetworkErrorHandler


#pragma mark - Initialization Methods


+ (instancetype)handler
{
    static QFNetworkErrorHandler   *handler;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[[self class] alloc] init];
    });
    
    return handler;
}


#pragma mark - Setter & Getter


- (NSString *)errorDomain
{
    return @"NSURLErrorDomain";
}


#pragma mark - Interface Methods


- (void)handleError:(NSError *)error
{
    if ([error.domain isEqualToString:self.errorDomain]) {
        
        [DPRemind simpleRemindMessage:@"网络错误，请稍后重试..."];
    }
    else {
        [self.nextHandler handleError:error];
    }
}

@end
