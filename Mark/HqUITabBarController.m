//
//  HqUITabBarController.m
//  Mark
//
//  Created by hongqing on 16/3/5.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "WantViewController.h"
#import "WatchedViewController.h"
#import "SearchViewController.h"
#import "CollectionViewController.h"
#import "HqUITabBarController.h"

@implementation HqUITabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *titleHighlightedColor = UpColor;
    UIColor *titleNomalColor = DownColor;
//    self.hidesBottomBarWhenPushed =YES;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleNomalColor, UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor, UITextAttributeTextColor,
        nil] forState:UIControlStateSelected];
}


@end
