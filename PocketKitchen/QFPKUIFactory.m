//
//  QFPKUIFactory.m
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFPKUIFactory.h"

@implementation QFPKUIFactory


#pragma mark - Create BBI


+ (UIBarButtonItem *)createProjectTitleBBI
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, 30)];
    titleLabel.text = @"掌厨-全球最大的视频厨房";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:21];
    UIBarButtonItem *titleBBI = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    return titleBBI;
}

+ (UIBarButtonItem *)createSpaceBBIWithWidth:(CGFloat)width
{
    UIBarButtonItem *spaceBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBBI.width = width;
    return spaceBBI;
}

+ (UIBarButtonItem *)createBackBBIWithTarget:(id)target action:(SEL)action
{
    // 创建一个View承载返回的图片和分割的竖线
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    
    // 返回图片
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backImageView.image = [UIImage imageNamed:@"nav_back"];
    [bgView addSubview:backImageView];
    
//    // 分割竖线
//    UIImageView *splitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(48, 0, 1, 44)];
//    splitImageView.image = [UIImage imageNamed:@"split_line"];
//    [bgView addSubview:splitImageView];
    
    // 添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [bgView addGestureRecognizer:tap];
    
    UIBarButtonItem *backBBI = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    
    return backBBI;
}

+ (UIBarButtonItem *)createSplitLineBBI
{
    UIBarButtonItem *splitLineBBI = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"split_line"] style:UIBarButtonItemStylePlain target:nil action:nil];
    splitLineBBI.tintColor = [UIColor whiteColor];
    return splitLineBBI;
}

+ (UIBarButtonItem *)createTitleBBI:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *titleBBI = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    titleBBI.tintColor = [UIColor whiteColor];
    
    return titleBBI;
}

+ (UIBarButtonItem *)createPKBBIWithTitle:(NSString *)title image:(UIImage *)image target:(id)tartget action:(SEL)selector
{
    // 设置一个容器来装图片和标题
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    
    // 设置图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:contentView.bounds];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [contentView addSubview:imageView];
    
    // 设置标题
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, contentView.bounds.size.width, 14)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = title;
    label.font = [UIFont systemFontOfSize:10];
    [contentView addSubview:label];
    
    // 设置点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:tartget action:selector];
    [contentView addGestureRecognizer:tapGesture];
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    
    return bbi;
}


#pragma mark - Other


+ (UIColor *)createVCBackgroundColor
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeview_bg"]];
}

+ (UIColor *)createThemeColor
{
    return [UIColor colorWithRed:254/255.0f green:120/255.0f blue:20/255.0f alpha:1.0f];
}

@end
