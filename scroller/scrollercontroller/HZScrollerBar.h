//
//  HZScrollerBar.h
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZScrollerItem.h"

@protocol HZScrollerBarDelegate;

@interface HZScrollerBar : UIView

@property (nonatomic, assign) id <HZScrollerBarDelegate> delegate;
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, strong) IBOutlet UIView *titleView;
@property (nonatomic, strong) HZScrollerItem *selectedItem;

- (void)setItems:(NSArray *)items animated:(BOOL)animated;

@end

@protocol HZScrollerBarDelegate <NSObject>

- (void)scrollerBar:(HZScrollerBar*)scrollerBar didSelectItem:(HZScrollerItem*)item;

@end