//
//  NavTableViewController.m
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import "NavTableViewController.h"

@interface NavTableViewController ()

@end

@implementation NavTableViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"%@ - awake from nib", NSStringFromClass([self class]));
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
