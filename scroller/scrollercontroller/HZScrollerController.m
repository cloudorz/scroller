//
//  HZScrollerController.m
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import "HZScrollerController.h"
#import <QuartzCore/QuartzCore.h>

@interface HZScrollerController () <UIScrollViewDelegate, UINavigationControllerDelegate, HZScrollerBarDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIView *maskView;
@end

@implementation HZScrollerController

- (void)dealloc
{
}

#pragma mark - init the scroller's controllers
- (void)configureViewControllersFromStoryboard
{
    // TODO: may use auto set
    UIStoryboard *storyboard = self.storyboard;
    self.viewControllers = @[[storyboard instantiateViewControllerWithIdentifier:@"tableC"],
                             [storyboard instantiateViewControllerWithIdentifier:@"navC"],
                             [storyboard instantiateViewControllerWithIdentifier:@"viewC"]];
    
}

- (void)doInitWork
{
    _selectedIndex = -1;
    [self configureViewControllersFromStoryboard];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"%@ - awake from nib", NSStringFromClass([self class]));
    [self doInitWork];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"I'm in...");
        [self doInitWork];
    }
    return self;
}

- (UIView *)maskView
{
    if (_maskView == nil)
    {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
    }
    
    return _maskView;
}

- (void)resetScrollViewHeight
{
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat deltaHeight = 0;
    if (self.scrollerBar.hidden == NO)
    {
        deltaHeight = self.scrollerBar.frame.size.height;
    }
    scrollViewFrame.size.height = self.view.frame.size.height - deltaHeight;
    scrollViewFrame.origin.y = deltaHeight;
    self.scrollView.frame= scrollViewFrame;
}

- (void)initAllControllersTitleView
{
    [self.viewControllers enumerateObjectsUsingBlock:^(id vc, NSUInteger idx, BOOL *stop){
        
        [[self getTopViewControllerFrom:vc] initTitleView];
    }];
}

- (void)initTheHeaderViewItems
{
    NSMutableArray *items = [NSMutableArray array];
    [self.viewControllers enumerateObjectsUsingBlock:^(id vc, NSUInteger idx, BOOL *stop){
        
        [vc setScrollerController:self];
        
        HZScrollerItem *item = nil;
        
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            [[vc topViewController] setScrollerController:self];
            [vc setDelegate:self];
            
            item = [[vc topViewController] scrollerItem];
        }
        else
        {
            item = [vc scrollerItem];
        }
        
        if (item)
        {
            [items addObject:item];
        }
        else
        {
            [items addObject:[HZScrollerItem scrollerItemWithImage:nil hintImage:nil]];
        }
    }];
    
    [self.scrollerBar setItems:items animated:NO];
}

- (void)addViewControllerToScroller:(UIViewController*)viewController
{
    if (viewController.view.superview == nil)
    {
        NSUInteger index = [self.viewControllers indexOfObject:viewController];
        viewController.view.frame = CGRectMake(self.scrollView.frame.size.width*index, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:viewController.view];
        NSLog(@"add viewcontroller view success.");
    }
    
}

- (id)getTopViewControllerFrom:(id)vc
{
    UIViewController *topVC = nil;
    if ([vc respondsToSelector:@selector(topViewController)])
    {
        topVC = [vc topViewController];
    }
    else
    {
        topVC = vc;
    }
    
    return topVC;
}

#pragma mark - scorller view init
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@ - view did load", NSStringFromClass([self class]));
    
    // round corner
    self.view.layer.cornerRadius = 4.f;
    self.view.layer.masksToBounds = YES;
    self.scrollerBar.delegate = self;

    [self initTheHeaderViewItems];
    
    [self initAllControllersTitleView];
    
    self.scrollView.contentSize = CGSizeMake(self.viewControllers.count*self.scrollView.frame.size.width, self.scrollView.frame.size.height);

    [self setSelectedIndex:1 animated:YES];
}

- (void)hideScorllerBar:(BOOL)hide
{
    self.scrollerBar.hidden = hide;
    [self resetScrollViewHeight];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated
{
    
#if DEBUG
    NSAssert(selectedIndex >= 0 && selectedIndex < self.viewControllers.count, @"Index out of bounds in scroller.");
#else
    if (selectedIndex < 0)
    {
        selectedIndex = 0;
    }
    else if (selectedIndex >= self.viewControllers.count)
    {
        selectedIndex = self.viewControllers.count - 1;
    }
#endif
    
    if (_selectedIndex != selectedIndex)
    {
        
        UIViewController *vc = self.viewControllers[selectedIndex];
        self.selectedViewController = vc;
        
        [self.scrollerBar setTitleView:[[self getTopViewControllerFrom:vc] scrollerTitleView]
                     animatedDirection:(selectedIndex > _selectedIndex) ? HZAnimatedRight : HZAnimatedLeft];
        
        if (vc.view.superview == nil)
        {
            [self addViewControllerToScroller:vc];
            // TODO: trigger didselect method
        }
        else
        {
            [[self getTopViewControllerFrom:vc] viewDidSelected:YES];
        }
        
        [self.scrollerBar selectItemAtIndex:selectedIndex animated:animated];
        
        if (!animated)
        {
        
            [self clearAllBlocks];
        }
        else
        {
            [self.scrollView scrollRectToVisible:vc.view.frame animated:animated];
        }
        
        _selectedIndex = selectedIndex;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@ - view will appear", NSStringFromClass([self class]));
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@ - view did appear", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    NSLog(@"%@ - view will disappear", NSStringFromClass([self class]));
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"%@ - view did disappear", NSStringFromClass([self class]));
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}


# pragma mark - scrollview delegate
- (void)setAllTopViewsUserInteraction:(BOOL)enabled
{
    self.scrollerBar.userInteractionEnabled = enabled;
    [self.viewControllers enumerateObjectsUsingBlock:^(id vc, NSUInteger idx, BOOL *stop){
        [[[self getTopViewControllerFrom:vc] view] setUserInteractionEnabled:enabled];
    }];
}

- (void)clearAllBlocks
{
    if (self.maskView.superview)
    {
        [self.maskView removeFromSuperview];
    }
    
    [self setAllTopViewsUserInteraction:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.scrollView isEqual:scrollView] && !scrollView.isDragging)
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        [self setSelectedIndex:page animated:NO];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat currentLeftX = self.selectedViewController.view.frame.origin.x;
    
    CGFloat delta = ABS(offsetX - currentLeftX);
    if (delta > 10 && (scrollView.decelerating || scrollView.dragging))
    {
        if (![self.maskView.superview isEqual:self.selectedViewController.view])
        {
            [self.selectedViewController.view addSubview:self.maskView];
        }
        self.maskView.alpha = 0.6*(delta/self.selectedViewController.view.frame.size.width);
        
        [self setAllTopViewsUserInteraction:NO];
    }
    else
    {
        if (!scrollView.isDragging)
        {
            [self clearAllBlocks];
        }
    }
}

#pragma mark - uinavigationcontroller delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ([self.selectedViewController isEqual:navigationController])
    {
        NSUInteger count = navigationController.viewControllers.count;
        
        self.scrollView.scrollEnabled = (count == 1); // 第一页可滑动
        
        viewController.scrollerController = self;
        
        if (count > 1 && [self.scrollerBar.superview isEqual:self.view])
        {
            [self.scrollerBar removeFromSuperview];
            [[navigationController.viewControllers[0] view] addSubview:self.scrollerBar];
        }
        
        NSLog(@"view contller will show: %@", viewController);
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.selectedViewController isEqual:navigationController])
    {
        NSUInteger count = navigationController.viewControllers.count;
        
        if (count == 1 && ![self.scrollerBar.superview isEqual:self.view])
        {
            [self.scrollerBar removeFromSuperview];
            [self.view addSubview:self.scrollerBar];
        }
        
        NSLog(@"view contller did show: %@", viewController);
    }

}

#pragma mark - scroller selected
- (void)scrollerBar:(HZScrollerBar *)scrollerBar didSelectItem:(HZScrollerItem *)item atIndex:(NSUInteger)index
{
    if ([scrollerBar isEqual:self.scrollerBar])
    {
        [self setAllTopViewsUserInteraction:NO];
        [self setSelectedIndex:index animated:YES];
    }
}

- (BOOL)scrollerBar:(HZScrollerBar *)scrollerBar shouldSelectItem:(HZScrollerItem *)item atIndex:(NSUInteger)index
{
    return ([scrollerBar isEqual:self.scrollerBar] && self.scrollView.scrollEnabled);
}

- (void)checkForShowPopTitleView
{
    [self.scrollerBar setPopTitle:[NSString stringWithFormat:@"%@门新课上架了", @(4)] at:2];
}
@end
