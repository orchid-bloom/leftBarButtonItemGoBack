//
//  QFCoreDataDocumentManager.h
//  PocketKitchen
//
//  Created by Tema on 15/3/17.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QFCoreDataDefine.h"

/**
 枚举，用于标识Document初始化是否成功的状态
 */
typedef NS_ENUM(NSUInteger, QFCoreDataDocumentManagerStatus) {
    QFCoreDataDocumentOpenSucceed,
    QFCoreDataDocumentOpenFailed,
    QFCoreDataDocumentCreateFailed
};

/**
 CoreData的Document管理者，是一个单例
 */
@interface QFCoreDataDocumentManager : NSObject
{
    UIManagedDocument   *_managedDocument;
    QFCoreDataDocumentManagerStatus _documentStatus;
}

@property (nonatomic, readonly) UIManagedDocument   *managedDocument;
@property (nonatomic, readonly) QFCoreDataDocumentManagerStatus documentStatus;

/**
 单例接口
 */
+ (instancetype)manager;

@end
