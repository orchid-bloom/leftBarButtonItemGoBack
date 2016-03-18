//
//  QFUser.h
//  PocketKitchen
//
//  Created by Tema on 15/5/4.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 用户的数据模型
 */
@interface QFUser : NSObject

@property (nonatomic, copy) NSString    *channel;
@property (nonatomic, copy) NSString    *headFileName;
@property (nonatomic, copy) NSString    *loginName;
@property (nonatomic, copy) NSString    *loginPwd;
@property (nonatomic, copy) NSString    *md5pwd;
@property (nonatomic, copy) NSString    *name;
@property (nonatomic, copy) NSString    *phone;
@property (nonatomic, copy) NSString    *regDate;
@property (nonatomic, copy) NSString    *lastLoginDate;
@property (nonatomic, copy) NSString    *userId;
@property (nonatomic, copy) NSString    *userImage;
@property (nonatomic, copy) NSString    *userName;

@end


/**
 快速创建User的类别
 */
@interface QFUser (Create)

+ (instancetype)userWithData:(id)data;

@end
