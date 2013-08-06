//
//  NavTableViewController.m
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import "NavTableViewController.h"

@interface NavTableViewController ()
@property (strong, nonatomic) UILabel *label;
@end

@implementation NavTableViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initTitleView];
    NSLog(@"%@ - awake from nib", NSStringFromClass([self class]));
}

- (void)initTitleView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:28.0f];
    label.textColor = [UIColor whiteColor];
    label.text = @"我是首页";
    
    self.scrollerTitleView = label;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
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

- (void)viewDidSelected:(BOOL)animated
{
    [super viewDidSelected:animated];

    NSLog(@"%@ - view did selected", NSStringFromClass([self class]));
}

#pragma mark - Table view data source
- (HZScrollerItem*)scrollerItem
{
    HZScrollerItem *item = [HZScrollerItem scrollerItemWithImage:[UIImage imageNamed:@"Indicator_Home"]
                                       hintImage:[UIImage imageNamed:@"Indicator_Home_Hit"]];
    item.itemName = @"Home";
    return item;
}

@end
