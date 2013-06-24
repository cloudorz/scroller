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

- (BOOL)isModal
{
    
    BOOL isModal = ((self.parentViewController && self.parentViewController.modalViewController == self) ||
                    //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                    ( self.navigationController && self.navigationController.parentViewController && self.navigationController.parentViewController.modalViewController == self.navigationController) ||
                    //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                    [[[self tabBarController] parentViewController] isKindOfClass:[UITabBarController class]]);
    
    //iOS 5+
    if (!isModal && [self respondsToSelector:@selector(presentingViewController)]) {
        
        isModal = ((self.presentingViewController && self.presentingViewController.modalViewController == self) ||
                   //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                   (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.modalViewController == self.navigationController) ||
                   //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                   [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]]);
        
    }
    
    return isModal;
    
}

@end
