//
//  QFTouchImageView.h
//  PocketKitchen
//
//  Created by Tema on 15/3/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 这是一个带点击事件的ImageView
 */
@interface QFTouchImageView : UIImageView

@property (strong,nonatomic) id userInfo;

/**
 设置ImageView的点击事件
 */
-(void)setTarget:(id)target action:(SEL)action;

@end
