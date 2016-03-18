//
//  QFTouchImageView.m
//  PocketKitchen
//
//  Created by Tema on 15/3/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFTouchImageView.h"

@implementation QFTouchImageView
{
    id _target;
    SEL _action;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)awakeFromNib
{
    self.userInteractionEnabled = YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_target && [_target respondsToSelector:_action])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_target performSelector:_action withObject:self];
#pragma clang diagnostic pop
        
    }
}

-(void)setTarget:(id)target action:(SEL)action
{
    _target = target;
    _action = action;
}

@end
