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
const static CGFloat kMargin = 12.0f;

@interface HZScrollerBar ()

@property (nonatomic, strong) NSNumber *selectedItemIndex;
@property (nonatomic, strong) UIView *titleView;

@end

@implementation HZScrollerBar

- (void)doInitBar
{
    self.clipsToBounds = YES;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self doInitBar];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self doInitBar];
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
        
        CGFloat x = self.frame.size.width - (kMargin + kItemWidth*items.count + kitemDistance*(items.count-1));
        
        [items enumerateObjectsUsingBlock:^(HZScrollerItem *item, NSUInteger idx, BOOL *stop){
            
            item.frame = CGRectMake(x+(kItemWidth+kitemDistance)*idx, (self.frame.size.height-kItemHeight)/2, kItemWidth, kItemHeight);

            [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];

            [self addSubview:item];
        }];
    }
}

- (void)itemAction:(HZScrollerItem*)item
{
    
    NSUInteger index = [self.items indexOfObject:item];
    
    [self setSelectedItemIndex:@(index)];
    
    if ([self.delegate respondsToSelector:@selector(scrollerBar:didSelectItem:atIndex:)])
    {
        [self.delegate scrollerBar:self didSelectItem:item atIndex:index];
    }
}

- (void)setSelectedItemIndex:(NSNumber*)selectedItemIndex
{
    if (![_selectedItemIndex isEqualToNumber:selectedItemIndex])
    {
        _selectedItemIndex = selectedItemIndex;
        
        self.selectedItem.selected = NO;
        
        HZScrollerItem *item = self.items[selectedItemIndex.integerValue];
        item.selected = YES;
        
        self.selectedItem = item;
    }
}

- (void)selectItemAtIndex:(NSUInteger)index animated:(BOOL)animated
{
    self.selectedItemIndex = @(index);
}

- (void)setTitleView:(UIView *)titleView animatedDirection:(HZAnimatedDirection)direction
{
    if (!titleView)
    {
        return;
    }
    
    CGAffineTransform newViewTransform;
    newViewTransform = CGAffineTransformMakeTranslation(kMargin, (self.frame.size.height-titleView.frame.size.height)/2);
    
    if (!_titleView || direction == HZAnimatedNo)
    {
        [_titleView removeFromSuperview];
        
        titleView.transform = newViewTransform;
        [self addSubview:titleView];
        
        _titleView = titleView;
    }
    else
    {
        CGAffineTransform oldViewTransform;

        switch (direction) {
            case HZAnimatedLeft:
                oldViewTransform = CGAffineTransformMakeTranslation(_titleView.frame.origin.x+_titleView.frame.size.width, _titleView.frame.origin.y);
                titleView.transform = CGAffineTransformMakeTranslation(-titleView.frame.size.width, (self.frame.size.height-titleView.frame.size.height)/2);
                break;
                
            case HZAnimatedTop:
                oldViewTransform = CGAffineTransformMakeTranslation(kMargin, self.frame.size.height);
                titleView.transform = CGAffineTransformMakeTranslation(kMargin, -titleView.frame.size.height);
                break;
                
            default:
                break;
        }
        
        titleView.alpha = 0.25;
        [self addSubview:titleView];
        
        [UIView animateWithDuration:0.36
                         animations:^{
                             _titleView.transform = oldViewTransform;
                             _titleView.alpha = 0.25;
                             titleView.transform = newViewTransform;
                             titleView.alpha = 0.7;
                         }
                         completion:^(BOOL finished){
                             [_titleView removeFromSuperview];
                             _titleView = titleView;
                             
                             [UIView animateWithDuration:0.2
                                              animations:^{
                                                  titleView.alpha = 1.0;
                                              }];
                         }];
    }

}

@end
