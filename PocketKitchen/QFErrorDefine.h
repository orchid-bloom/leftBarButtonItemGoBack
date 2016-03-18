//
//  QFErrorDefine.h
//  PocketKitchen
//
//  Created by Tema on 15/3/17.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//


/**
 这里定义了Error相关的一些宏，包括：
    Error 的 domain
    Error 的 code
 */

#include <Foundation/Foundation.h>

#ifndef PocketKitchen_QFErrorDefine_h
#define PocketKitchen_QFErrorDefine_h


#define ERROR_DOMAIN_COREDATA @"com.PocketKitchen.CoreData"     // CoreData相关错误的Domain
#define ERROR_CODE_COREDATA_OPENFAILED (100001)     // CoreData中Document打开失败的Code
#define ERROR_CODE_COREDATA_CREATEFAILED (100002)   // CoreData中Document创建文件失败的Code
#define ERROR_CODE_COREDATA_WRONGDATA (100003)      // CoreData中查询的数据不符合预期


#define ERROR_DOMAIN_SERVERDATA @"com.PocketKitchen.ServerData" // 服务器错误的Domain
#define ERROR_CODE_SERVERDATA (200001)      // 服务器数据错误

#endif
