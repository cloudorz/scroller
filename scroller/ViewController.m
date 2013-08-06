//
//  ViewController.m
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UILabel *label;
@end

@implementation ViewController

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
    label.text = @"我是设置页";
    
    self.scrollerTitleView = label;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTitleView];
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
    [self setScollerPopTitle:@"亲，你的邮箱还没有设置哦" at:2];
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
