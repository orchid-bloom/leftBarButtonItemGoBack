//
//  QFPKTabBarButton.h
//  PocketKitchen
//
//  Created by Tema on 15/3/6.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 这个是自定义的TabBar上的按钮，可以定义选中图片，非选中的图片，和标题
 */
@interface QFPKTabBarButton : UIView

@property (nonatomic, retain)   UIImage *unselectedImg;
@property (nonatomic, retain)   UIImage *selectedImg;
@property (nonatomic, assign)   id      target;
@property (nonatomic, assign)   SEL     action;

@property (nonatomic, assign)   BOOL    selected;


/**
 按钮的初始化方法
 */
- (id)initWithFrame:(CGRect)frame unselectedImage:(UIImage *)unselectedImg selectedImage:(UIImage *)selectedImg title:(NSString *)title;

/**
 给按钮添加点击事件
 */
- (void)setClickEventTarget:(id)target action:(SEL)action;

@end
