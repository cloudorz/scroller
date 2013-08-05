//
//  ViewController.m
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"%@ - awake from nib", NSStringFromClass([self class]));
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

- (void)viewDidSelected:(BOOL)animated
{
    [super viewDidSelected:animated];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:28.0f];
    label.text = @"我是设置页";
    [self setTitleView:label animatedDirection:(animated ? HZAnimatedLeft : HZAnimatedNo)];
    NSLog(@"%@ - view did selected", NSStringFromClass([self class]));
}

- (IBAction)showModalPage:(id)sender
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"showModal"];
    [self.scrollerController presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (HZScrollerItem*)scrollerItem
{
    HZScrollerItem *item = [HZScrollerItem scrollerItemWithImage:[UIImage imageNamed:@"Indicator_Setting"]
                                                       hintImage:[UIImage imageNamed:@"Indicator_Setting_Hit"]];
    item.itemName = @"Setting";
    
    return item;
}

@end
