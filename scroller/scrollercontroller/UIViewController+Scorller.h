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

@interface UIViewController (Scorller)

@property (strong, nonatomic) HZScrollerController *scrollerController;
@property (strong, nonatomic) HZScrollerItem *scrollerItem;

- (BOOL)shouldScrollerScrollable;
- (BOOL)shouldHideScrollerBar;
- (void)viewDidSelected:(BOOL)animated;
@end
