//
//  QFErrorHandlerManager.h
//  PocketKitchen
//
//  Created by Tema on 15/3/16.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QFErrorHandler.h"
#import "QFUnknownErrorHandler.h"
#import "QFNetworkErrorHandler.h"
#import "QFErrorDefine.h"

@interface QFErrorHandlerManager : NSObject
{
    NSMutableArray  *_handlersChain;
}

@property (nonatomic, readonly) NSMutableArray  *handlersChain;

+ (instancetype)manager;
+ (void)configurationHandlers;

@end
