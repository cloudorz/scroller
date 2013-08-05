//
//  HZScrollerBar.m
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import "HZScrollerBar.h"

const static CGFloat kItemWidth = 20.0f;
const static CGFloat kitemDistance = 3.0f;
const static CGFloat kItemHeight = 20.0f;

@implementation HZScrollerBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setItems:(NSArray *)items animated:(BOOL)animated
{
    if (![_items isEqualToArray:items])
    {
        // clear the old ones
        [_items enumerateObjectsUsingBlock:^(HZScrollerItem *item, NSUInteger idx, BOOL *stop){
            [item removeFromSuperview];
        }];
        
        _items = items;
        CGFloat x = self.frame.size.width - (12 + kItemWidth*items.count + kitemDistance*(items.count-1));
        [items enumerateObjectsUsingBlock:^(HZScrollerItem *item, NSUInteger idx, BOOL *stop){
            item.frame = CGRectMake(x+(kItemWidth+kitemDistance)*idx, (self.frame.size.height-kItemHeight)/2, kItemWidth, kItemHeight);
            [self addSubview:item];
        }];
    }
}

@end
