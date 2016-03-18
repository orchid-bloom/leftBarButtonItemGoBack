//
//  QFPKNetAPIResponseSerializer.m
//  PocketKitchen
//
//  Created by Tema on 15/3/9.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFPKNetAPIResponseSerializer.h"
#import "GlobalDefine.h"

@implementation QFPKNetAPIResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
    id responseObj = [super responseObjectForResponse:response data:data error:error];
    
    QFPKHTTPResponseResult *result = [[QFPKHTTPResponseResult alloc] initWithJSON:responseObj];
    
    return result;
}

@end
