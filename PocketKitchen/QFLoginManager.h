//
//  QFLoginManager.h
//  PocketKitchen
//
//  Created by Tema on 15/5/4.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QFUser.h"
#import "GlobalDefine.h"
#import "AFNetworking.h"
#import "QFPKNetInterface.h"
#import <TencentOpenAPI/TencentOAuth.h>


#define kUserLoginStatusChangedNotification @"kUserLoginStatusChangedNotification"


/**
 登录状态的枚举
 */
typedef enum QFLoginStatus {
    QFLoginStatusNoLogined,
    QFLoginStatusLogining,
    QFLoginStatusSuccessed,
    QFLoginStatusFailed
}QFLoginStatus;


/**
 登录回调的Block
 */
typedef void (^LoginCompletion)(QFLoginStatus status, QFUser *user);


/**
 登录管理器，处理用户登录相关的逻辑
 */
@interface QFLoginManager : NSObject <TencentSessionDelegate>

@property (nonatomic, assign) QFLoginStatus status;
@property (nonatomic, readonly) QFUser      *currentUser;
@property (nonatomic, strong) TencentOAuth       *tencentOAuth;
@property (nonatomic, copy) LoginCompletion     qqLoginCallback;

// 单例的入口
+ (instancetype)instance;

/**
 登录
 */
- (void)loginWithID:(NSString *)userID
           password:(NSString *)password
         completion:(LoginCompletion)callback;

/**
 QQ登录
 */
- (void)qqLoginWithCompletion:(LoginCompletion)callback;

@end
