//
//  QFErrorHandlerManager.m
//  PocketKitchen
//
//  Created by Tema on 15/3/16.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFErrorHandlerManager.h"

@implementation QFErrorHandlerManager


#pragma mark - Initialization Methods


- (instancetype)init
{
    if (self = [super init]) {
        _handlersChain = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+ (instancetype)manager
{
    static QFErrorHandlerManager    *manager;
    static dispatch_once_t          token;
    dispatch_once(&token, ^{
        manager = [[[self class] alloc ] init];
    });
    return manager;
}


#pragma mark - Setter & Getter


- (NSMutableArray *)handlersChain
{
    return _handlersChain;
}


#pragma mark - Interface Methods


+ (void)configurationHandlers
{
    NSMutableArray *handlersChain = [[self manager] handlersChain];
    
    [handlersChain addObject:[QFErrorHandler handler]];
    [handlersChain addObject:[QFNetworkErrorHandler handler]];
    [handlersChain addObject:[QFUnknownErrorHandler handler]];
}

@end
