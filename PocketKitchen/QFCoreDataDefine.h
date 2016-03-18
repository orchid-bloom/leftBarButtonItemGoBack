//
//  QFCoreDataDefine.h
//  PocketKitchen
//
//  Created by Tema on 15/3/17.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//


/**
 这里定义了CoreData用到的宏，包括：
    sqlite数据库的文件名
    各个entity的字句
 */

#ifndef PocketKitchen_QFCoreDataDefine_h
#define PocketKitchen_QFCoreDataDefine_h


// sqlite数据库文件名
#define CD_STORE_FILE_NAME @"cookbook.sqlite"


// entity名
#define CD_ENTITY_NAME_COOKBOOKSECTION @"QFCookbookSection"
#define CD_ENTITY_NAME_VEGETABLE @"QFVegetable"
#define CD_ENTITY_NAME_ADVERTISEMENT @"QFAdvertisement"
#define CD_ENTITY_NAME_PLAZAITEMS @"QFPlazaItems"
#define CD_ENTITY_NAME_PLAZACOMMENTS @"QFPlazaComments"


#endif
