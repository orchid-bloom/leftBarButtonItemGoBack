//
//  QFVegetableVideoDetailHeader.m
//  PocketKitchen
//
//  Created by Tema on 15/5/22.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFVegetableVideoDetailHeader.h"

@implementation QFVegetableVideoDetailHeader

#pragma mark - Setter & Getter

- (void)setTapGesture:(UITapGestureRecognizer *)tapGesture
{
    if (_tapGesture != tapGesture) {
        
        if (_tapGesture) {
            [self removeGestureRecognizer:_tapGesture];
        }
        
        [self addGestureRecognizer:tapGesture];
        _tapGesture = tapGesture;
    }
}

@end
