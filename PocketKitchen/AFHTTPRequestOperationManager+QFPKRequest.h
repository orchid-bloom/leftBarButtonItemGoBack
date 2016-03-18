//
//  AFHTTPRequestOperationManager+QFPKRequest.h
//  PocketKitchen
//
//  Created by Tema on 15/3/9.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
@class QFPKHTTPResponseResult;


/**
 这是一个用来封装这个项目网络请求的类别
 */
@interface AFHTTPRequestOperationManager (QFPKRequest)


/**
 对AFNetworking请求的进一步封装
 在请求之前，会先拿到服务器的ip，如果没有ip，就在这个请求之前，先去请求ip，然后才会进行这次请求
 这个函数的参数和AFNetworking的参数一致
 */
- (AFHTTPRequestOperation *)GETRequest:(NSString *)URLString
        parameters:(id)parameters
           success:(void (^)(AFHTTPRequestOperation *operation, QFPKHTTPResponseResult *result))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/**
 对请求操作的进一步封装，使控制器里的请求的代码更简洁
 */
+ (AFHTTPRequestOperation *)GETRequest:(NSString *)URLString
                            parameters:(id)parameters
                               success:(void (^)(AFHTTPRequestOperation *operation, QFPKHTTPResponseResult * result))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
