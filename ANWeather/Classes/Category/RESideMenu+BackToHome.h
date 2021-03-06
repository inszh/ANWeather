//
//  RESideMenu+BackToHome.h
//  ANWeather
//
//  Created by a on 16/1/12.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "RESideMenu.h"

@interface RESideMenu (BackToHome)
/**
 *  回到首页并把所选城市带过去
 */
- (void)backToHomeViewControllerWithSelectedCity:(NSString *)selectedCity;

/**
 *  转到控制器
 */
- (void)toViewController:(UIViewController *)viewController;
/**
 *  回到首页
 */
- (void)backToHomeViewController;

@end
