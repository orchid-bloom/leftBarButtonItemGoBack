//
//  QFSearchSelectedItemView.h
//  PocketKitchen
//
//  Created by Tema on 15/5/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QFSearchSelectedItemView;


#pragma mark - QFSearchSelectedItemViewDelegate


@protocol QFSearchSelectedItemViewDelegate <NSObject>

- (void)itemViewDidClickedRemoveButton:(QFSearchSelectedItemView *)itemView;

@end


#pragma mark - QFSearchSelectedItemView


/**
 搜索框头部显示被选中的菜单种类的，这包含了一个Label和一个删除的Button
 */
@interface QFSearchSelectedItemView : UIView
{
    UILabel     *_titleLabel;
    UIButton    *_removeButton;
}

@property (nonatomic, strong)   id          userInfo;
@property (nonatomic, assign)   id<QFSearchSelectedItemViewDelegate> delegate;

/**
 根据给定的信息，初始化一个ItemView

 @param title       itemView显示的标题
 @param delegate    回调的代理
 @param userInfo    用户数据
 */
- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                     delegate:(id<QFSearchSelectedItemViewDelegate>)delegate
                     userInfo:(id)userInfo;

/**
 改变一个ItemView的Title和userInfo
 */
- (void)setTitle:(NSString *)title userInfo:(id)userInfo;

@end
