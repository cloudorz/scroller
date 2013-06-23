//
//  HZScrollerController.m
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import "HZScrollerController.h"
#import "UIViewController+Scorller.h"

@interface HZScrollerController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation HZScrollerController

- (void)awakeFromNib
{
    [super awakeFromNib];
     NSLog(@"%@ - awake from nib", NSStringFromClass([self class]));
    [self configureViewControllersFromStoryboard];
}

- (void)configureViewControllersFromStoryboard
{
    // TODO: may use auto set
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.viewControllers = @[[storyboard instantiateViewControllerWithIdentifier:@"tableC"],
                             [storyboard instantiateViewControllerWithIdentifier:@"navC"],
                             [storyboard instantiateViewControllerWithIdentifier:@"viewC"]];
    ;
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL *stop){
        vc.scrollerController = self;
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
    
    [self resetScrollViewHeight];
    
    self.scrollView.contentSize = CGSizeMake(self.viewControllers.count*self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    self.selectedIndex = 1;

}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [self setSelectedIndex:selectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated
{
    if (_selectedIndex != selectedIndex)
    {
        _selectedIndex = selectedIndex;
        
        UIViewController *vc = self.viewControllers[selectedIndex];
        [self addViewControllerToScroller:vc];
        self.selectedViewController = vc;
        
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            UINavigationController *nav = (UINavigationController*)vc;
            [nav.topViewController viewDidSelected:YES];
        }
        else
        {
            [vc viewDidSelected:YES];
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

- (void)scrollToController:(NSUInteger)index animated:(BOOL)animated
{
    
}


# pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.scrollView isEqual:scrollView])
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.selectedIndex = page;
    }
    
}
@end
