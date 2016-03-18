//
//  QFGuideViewController.h
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QFGuideDelegate <NSObject>

- (void)guideDidFinished;

@end

@interface QFGuideViewController : UIViewController

@property (nonatomic, assign) id<QFGuideDelegate>   delegate;

@end
