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

@interface HZScrollerBar ()

@property (nonatomic, strong) NSNumber *selectedItemIndex;

@end

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
        // clear the old item
        [_items enumerateObjectsUsingBlock:^(HZScrollerItem *item, NSUInteger idx, BOOL *stop){
            [item removeFromSuperview];
        }];
        
        // add the new items
        _items = items;
        
        CGFloat x = self.frame.size.width - (12 + kItemWidth*items.count + kitemDistance*(items.count-1));
        
        [items enumerateObjectsUsingBlock:^(HZScrollerItem *item, NSUInteger idx, BOOL *stop){
            
            item.frame = CGRectMake(x+(kItemWidth+kitemDistance)*idx, (self.frame.size.height-kItemHeight)/2, kItemWidth, kItemHeight);

            [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];

            [self addSubview:item];
        }];
    }
}

- (void)itemAction:(HZScrollerItem*)item
{
    self.selectedItem.selected = NO;
    
    item.selected = YES;
    
    self.selectedItem = item;
    
    if ([self.delegate respondsToSelector:@selector(scrollerBar:didSelectItem:atIndex:)])
    {
        [self.delegate scrollerBar:self didSelectItem:item atIndex:self.selectedItemIndex.integerValue];
    }
}

- (void)setSelectedItemIndex:(NSNumber*)selectedItemIndex
{
    if (![_selectedItemIndex isEqualToNumber:selectedItemIndex])
    {
        _selectedItemIndex = selectedItemIndex;
        
        [self itemAction:self.items[selectedItemIndex.integerValue]];
    }
}

- (void)selectItemAtIndex:(NSUInteger)index animated:(BOOL)animated
{
    self.selectedItemIndex = @(index);
}

@end
