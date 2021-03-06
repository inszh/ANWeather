//
//  RESideMenu+BackToHome.m
//  ANWeather
//
//  Created by a on 16/1/12.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "RESideMenu+BackToHome.h"
#import "ViewController.h"

@implementation RESideMenu (BackToHome)

/**
 *  回到首页并把所选城市带过去
 */
- (void)backToHomeViewControllerWithSelectedCity:(NSString *)selectedCity
{
    ViewController *HomeVc = [[ViewController alloc] init];
    HomeVc.isFromRight = YES;
    
    HomeVc.selectedCity = selectedCity;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:HomeVc];
    
    [self setContentViewController:nav animated:YES];
    
    [self hideMenuViewController];
}

/**
 *  跳到控制器
 */
- (void)toViewController:(UIViewController*)viewController
{
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self setContentViewController:nav animated:YES];
    
    [self hideMenuViewController];
}

/**
 *  跳到控制器
 */
- (void)backToHomeViewController
{
    ViewController *HomeVc = [[ViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:HomeVc];
    
    [self setContentViewController:nav animated:YES];
    
    [self hideMenuViewController];
}
@end
