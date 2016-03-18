//
//  GlobalDefine.h
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//


/**
 这里引用了整个项目常用到类
 */

#ifndef PocketKitchen_GlobalDefine_h
#define PocketKitchen_GlobalDefine_h


#import "QFPKUIFactory.h"
#import "AFNetworking.h"            
#import "AFHTTPRequestOperationManager+QFPKRequest.h"
#import "QFPKNetInterface.h"
#import "QFPKHTTPResponseResult.h"
#import "QFPKNetAPIResponseSerializer.h"
#import "QFErrorHandlerManager.h"
#import "DPUtility.h"
#import "QFCoreDataDocumentManager.h"
#import "JGProgressHUD+QFPocketKitchen.h"
#import "QFTouchImageView.h"
#import "UIImageView+WebCache.h"


/**
 版本控制
 */
#define APP_VERSION @"1.0.0"
#define DB_VERSION @"1.0.0"

//#define DB_VERSION (1.1.0)

/**
 腾讯开发平台 AppID
 */
#define TENCENT_APPID @"222222"

#endif
