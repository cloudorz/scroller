# scroller
一个通过左右滑动来管理controllers的container controller
## Install

* 将scrollercontroller拖入项目中
* 在<你的项目名>.pch添加 UIViewController+Scorller.h

```
 #import <Availability.h>

 #ifndef __IPHONE_5_0
 #warning "This project uses features only available in iOS SDK 5.0 and later."
 #endif

 #ifdef __OBJC__
     #import <UIKit/UIKit.h>
     #import <Foundation/Foundation.h>
     #import "UIViewController+Scroller.h"
 #endif
```
* 添加 QuartzCore.framework

##使用  (***详细看demo***)
* 创建继承于HZScrollerContrller的container controller
* contianer controller符合HZScrollerControllerProtocol
* 配置content viewcontrollers  

```
 - (void)configureViewControllers
{

    UIStoryboard *storyboard = self.storyboard;
    self.viewControllers = @[[storyboard instantiateViewControllerWithIdentifier:@"tableC"],
                             [storyboard instantiateViewControllerWithIdentifier:@"navC"],
                             [storyboard instantiateViewControllerWithIdentifier:@"viewC"]];
    
    self.defaultSelectedIndex = 1;
}
```  
* content viewcontoller符合HZScrollerProtocol
* 配置scroller bar左边的title view 

```
- (void)initTitleView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:28.0f];
    label.textColor = [UIColor blackColor];
    label.text = @"我是榜单页";
    
    self.scrollerTitleView = label;
}
```

* 配置scroller bar右边的scroller item

```
- (HZScrollerItem*)scrollerItem
{
    HZScrollerItem *item = [HZScrollerItem scrollerItemWithImage:[UIImage imageNamed:@"Indicator_Tops"]
                                                       hintImage:[UIImage imageNamed:@"Indicator_Tops_Hit"]];
    item.itemName = @"Tops";
    
    return item;
}
```

* 当前页面被选中的event

```
- (void)viewDidSelected:(BOOL)animated
{
    [super viewDidSelected:animated];
    [self setScollerPopTitle:@"你的名次有掉落了哦" at:0];    
    NSLog(@"%@ - view did selected", NSStringFromClass([self class]));

}
```

