//
//  HZScrollerController.m
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import "HZScrollerController.h"

@interface HZScrollerController ()
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSLog(@"%@ - view did load", NSStringFromClass([self class]));
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
@end
