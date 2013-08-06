//
//  HZScrollerItem.m
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import "HZScrollerItem.h"

@implementation HZScrollerItem

+ (id)scrollerItemWithImage:(UIImage*)img hintImage:(UIImage*)hintImg
{
    HZScrollerItem *item = [[self class] buttonWithType:UIButtonTypeCustom];

    [item setBackgroundImage:img forState:UIControlStateNormal];
    [item setBackgroundImage:hintImg forState:UIControlStateHighlighted];
    [item setBackgroundImage:hintImg forState:UIControlStateSelected];
    
    return item;
}

@end
