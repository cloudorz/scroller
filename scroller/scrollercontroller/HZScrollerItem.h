//
//  HZScrollerItem.h
//  scroller
//
//  Created by Cloud Dai on 13-6-23.
//  Copyright (c) 2013年 Cloud Dai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZScrollerItem : UIButton

@property (strong, nonatomic) NSString *itemName;

+ (id)scrollerItemWithImage:(UIImage*)img hintImage:(UIImage*)hintImg;
@end
