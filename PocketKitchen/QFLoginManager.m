//
//  QFLoginManager.m
//  PocketKitchen
//
//  Created by Tema on 15/5/4.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFLoginManager.h"
#import "AFNetworking.h"
#import "QFPKNetInterface.h"
#import "GlobalDefine.h"
//#import "QFUser+Database.h"

@implementation QFLoginManager


#pragma mark - Initialization Methods


// 单例的实现
+ (instancetype)instance
{
    static QFLoginManager *_manager;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _manager = [[QFLoginManager alloc] init];
    });
    
    return _manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:TENCENT_APPID andDelegate:self];
    }
    
    return self;
}


#pragma mark - Setter & Getter


- (void)setStatus:(QFLoginStatus)status
{
    if (_status != status) {
        _status = status;
        
        NSDictionary *userInfo = nil;
        if (_currentUser) {
            userInfo = @{@"status": @(_status), @"currentUser": _currentUser};
        }
        else {
            userInfo = @{@"status": @(_status)};
        }
        
        // 状态发生改变的时候，发一个全局通知，告诉别人，已经登录成功
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginStatusChangedNotification object:nil userInfo:userInfo];
    }
}


#pragma mark - Interface Methods


- (void)loginWithID:(NSString *)userID password:(NSString *)password completion:(LoginCompletion)callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = @{@"loginName": userID,
                             @"password": [password md5String],
                             @"md5": @"3336",
                             @"is_traditional": @"0"};
    
    self.status = QFLoginStatusLogining;
    
   [manager POST:URL_Login parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
       if ([responseObject[@"status"] isEqualToString:@"1"]){
           // 登录成功
           
           // 根据返回的数据，实例化用户信息
           QFUser *user = [QFUser userWithData:responseObject[@"data"]];
           
           // 保存成全局变量
           _currentUser = user;
           
           // 保存到数据库
//           [user saveToDB];
           
           // 登录成功之后，需要回调和改变状态
           self.status = QFLoginStatusSuccessed;
           callback(_status, _currentUser);
       }
       else {
           
           // 登录失败
           NSLog(@"%@", responseObject);
           NSLog(@"%@", responseObject[@"message"]);
           
           self.status = QFLoginStatusFailed;
           callback(_status, nil);
       }
       
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       NSLog(@"登录失败: %@", error);
       
      // 登录失败之后，需要回调和改变状态
       self.status = QFLoginStatusFailed;
       callback(_status, nil);
   }];
}

- (void)qqLoginWithCompletion:(LoginCompletion)callback
{
    NSArray *permissions = @[kOPEN_PERMISSION_ADD_TOPIC,
                             kOPEN_PERMISSION_GET_INFO,
                             kOPEN_PERMISSION_GET_USER_INFO];

    [_tencentOAuth authorize:permissions inSafari:NO];
    
    self.qqLoginCallback = callback;
}

- (void)tencentDidLogin
{
    if ([_tencentOAuth accessToken] && [_tencentOAuth accessToken].length > 0) {
        
        NSLog(@"登录成功");
        
        NSLog(@"%@", [_tencentOAuth accessToken]);
        NSLog(@"%@", [_tencentOAuth openId]);
        
        // 取用户信息
        [_tencentOAuth getUserInfo];
    }
    else {
        NSLog(@"登录失败");
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled) {
        
    }
    else {
        
    }
}

- (void)tencentDidLogout
{
    
}

- (void)tencentDidNotNetWork
{
    
}

- (void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"%@", response.jsonResponse[@"nickname"]);
    
    // 去调用掌厨的API，把登录信息传给掌厨
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = @{@"is_traditional": @"0", @"channel": @"App Store", @"tencenToken": [_tencentOAuth openId], @"userName": response.jsonResponse[@"nickname"]};
    
    [manager POST:URL_QQLogin parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@", responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]){
            // 登录成功
            
            // 根据返回的数据，实例化用户信息
            QFUser *user = [QFUser userWithData:[responseObject[@"data"] lastObject]];
            
            // 保存成全局变量
            _currentUser = user;
            
            // 保存到数据库
//            [user saveToDB];
            
            // 登录成功之后，需要回调和改变状态
            self.status = QFLoginStatusSuccessed;
            self.qqLoginCallback(_status, _currentUser);
        }
        else {
            
            // 登录失败
            NSLog(@"%@", responseObject);
            NSLog(@"%@", responseObject[@"message"]);
            
            self.status = QFLoginStatusFailed;
            self.qqLoginCallback(_status, nil);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}


@end
