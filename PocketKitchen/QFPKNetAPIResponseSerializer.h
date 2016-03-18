//
//  QFPKNetAPIResponseSerializer.h
//  PocketKitchen
//
//  Created by Tema on 15/3/9.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "AFURLResponseSerialization.h"

@interface QFPKNetAPIResponseSerializer : AFJSONResponseSerializer

/**
 重写构建返回对象的方法，把JSON结构，组成我们要用的对象
 */
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error;

@end
