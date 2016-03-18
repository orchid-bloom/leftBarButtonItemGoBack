//
//  QFErrorHandler.m
//  PocketKitchen
//
//  Created by Tema on 15/3/15.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFErrorHandler.h"
#import "QFNetworkErrorHandler.h"
#import "QFErrorHandlerManager.h"

@implementation QFErrorHandler


#pragma mark - Initialization Methods


/**
 单例的实现
 */
+ (instancetype)handler
{
    static QFErrorHandler   *handler;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[[self class] alloc] init];
    });
    
    return handler;
}


#pragma mark - Setter & Getter


- (NSString *)errorDomain
{
    return @"errorDomain";
}

- (QFErrorHandler *)nextHandler
{
    NSArray *handlersChain = [[QFErrorHandlerManager manager] handlersChain];
    NSInteger index = [handlersChain indexOfObject:self];
    if (index < handlersChain.count - 1) {
        return [handlersChain objectAtIndex:index+1];
    }
    
    return nil;
}


#pragma mark - Interface Methods


+ (void)handleError:(NSError *)error
{
    [[self handler] handleError:error];
}

- (void)handleError:(NSError *)error
{
    [self.nextHandler handleError:error];
}

@end

