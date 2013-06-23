//
//  UIViewController+Scorller.m
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import "UIViewController+Scorller.h"

#import <objc/runtime.h>

static const void *ScrollerControllerKey = &ScrollerControllerKey;
static const void *ScrollerItemKey = &ScrollerItemKey;
static const void *ScrollerTitleViewKey = &ScrollerTitleViewKey;

@implementation UIViewController (Scorller)
@dynamic scrollerController, scrollerItem, scrollerTitleView;

- (HZScrollerController*)scrollerController
{
    return objc_getAssociatedObject(self, ScrollerControllerKey);
}

- (void)setScrollerController:(HZScrollerController *)scrollerController
{
    objc_setAssociatedObject(self, ScrollerControllerKey, scrollerController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HZScrollerItem *)scrollerItem
{
    return objc_getAssociatedObject(self, ScrollerItemKey);
}

- (void)setScrollerItem:(HZScrollerItem *)scrollerItem
{
    objc_setAssociatedObject(self, ScrollerItemKey, scrollerItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)scrollerTitleView
{
    return objc_getAssociatedObject(self, ScrollerTitleViewKey);
}

- (void)setScrollerTitleView:(UIView *)scrollerTitleView
{
    objc_setAssociatedObject(self, ScrollerTitleViewKey, scrollerTitleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - extension method

- (BOOL)shouldScrollerScrollable
{
    return YES;
}

- (BOOL)shouldHideScrollerBar
{
    return NO;
}

// call this method when view did load
- (void)viewDidSelected:(BOOL)animated
{
    NSLog(@"Do Nothing");
}

@end
