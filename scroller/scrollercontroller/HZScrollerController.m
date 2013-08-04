//
//  HZScrollerController.m
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import "HZScrollerController.h"

@interface HZScrollerController () <UIScrollViewDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation HZScrollerController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
     NSLog(@"%@ - awake from nib", NSStringFromClass([self class]));
    _selectedIndex = -1;
    [self configureViewControllersFromStoryboard];
}

- (void)configureViewControllersFromStoryboard
{
    // TODO: may use auto set
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.viewControllers = @[[storyboard instantiateViewControllerWithIdentifier:@"tableC"],
                             [storyboard instantiateViewControllerWithIdentifier:@"navC"],
                             [storyboard instantiateViewControllerWithIdentifier:@"viewC"]];

    [self.viewControllers enumerateObjectsUsingBlock:^(id vc, NSUInteger idx, BOOL *stop){
        [vc setScrollerController:self];
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            [[vc topViewController] setScrollerController:vc];
            [vc setDelegate:self];
        }
    }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"I'm in...");
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@ - view did load", NSStringFromClass([self class]));
    
//    [self resetScrollViewHeight];
    
    self.scrollView.contentSize = CGSizeMake(self.viewControllers.count*self.scrollView.frame.size.width, self.scrollView.frame.size.height);

    [self setSelectedIndex:1 animated:NO];
}

- (void)hideScorllerBar:(BOOL)hide
{
    self.scrollerBar.hidden = hide;
    [self resetScrollViewHeight];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated
{
    if (_selectedIndex != selectedIndex)
    {
        _selectedIndex = selectedIndex;
        
//        UIViewController *prevVC = self.selectedViewController;
        
        UIViewController *vc = self.viewControllers[selectedIndex];
        self.selectedViewController = vc;
        
        if (vc.view.superview == nil)
        {
            [self addViewControllerToScroller:vc];
            // TODO: trigger didload method
        }
        else
        {
            if ([vc respondsToSelector:@selector(topViewController)])
            {
                [[(id)vc topViewController] viewDidSelected:YES];
            }
            else
            {
                [vc viewDidSelected:YES];
            }
        }
        
        [self.scrollView scrollRectToVisible:vc.view.frame animated:animated];
    }
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
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.scrollView isEqual:scrollView])
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        [self setSelectedIndex:page animated:NO];
    }

}

#pragma mark - uinavigationcontroller delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSUInteger count = navigationController.viewControllers.count;
    
    self.scrollView.scrollEnabled = ([viewController shouldScrollerScrollable] || count == 1); // 第一页必须可滑动
    
    viewController.scrollerController = self;
    
    if ([viewController shouldHideScrollerBar] &&
        count == 2 &&
        [self.scrollerBar.superview isEqual:self.view])
    {
        [self.scrollerBar removeFromSuperview];
        [[navigationController.viewControllers[0] view] addSubview:self.scrollerBar];
    }

    NSLog(@"view contller will show: %@", viewController);
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSUInteger count = navigationController.viewControllers.count;

    if (count == 1 && ![self.scrollerBar.superview isEqual:self.view])
    {
        [self.scrollerBar removeFromSuperview];
        [self.view addSubview:self.scrollerBar];
    }
    
    NSLog(@"view contller did show: %@", viewController);
}


@end
