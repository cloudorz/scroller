//
//  UIViewController+Scorller.h
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZScrollerController.h"
#import "HZScrollerItem.h"
#import "HZScrollerBar.h"

@interface UIViewController (Scorller)

@property (strong, nonatomic) HZScrollerController *scrollerController;
@property (strong, nonatomic) HZScrollerItem *scrollerItem;
@property (strong, nonatomic) UIView *scrollerTitleView;

- (void)jumpToControllerAtIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setScollerPopTitle:(NSString *)title at:(NSUInteger)index;
- (void)checkForScrollerBarShowPopTitleView;
- (void)viewDidSelected:(BOOL)animated;
- (void)initTitleView;
- (void)highScrollerBarShadow;
- (void)lowScrollerBarShadow;
- (BOOL)isModal;

// scroll view delegates
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
@end

@protocol HZScrollerProtocol <NSObject>

- (void)initTitleView;
- (HZScrollerItem*)scrollerItem;

@end