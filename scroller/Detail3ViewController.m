//
//  Detail3ViewController.m
//  scroller
//
//  Created by Cloud Dai on 13-8-4.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import "Detail3ViewController.h"

@interface Detail3ViewController ()

@end

@implementation Detail3ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
