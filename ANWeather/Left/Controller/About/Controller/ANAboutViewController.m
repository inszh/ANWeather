//
//  ANAboutViewController.m
//  ANWeather
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANAboutViewController.h"

@interface ANAboutViewController ()<AwesomeMenuDelegate>

@end

@implementation ANAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self.sideMenuViewController Action:@selector(presentLeftMenuViewController) andImageName:@"back" andImageNameHighlight:@"back"];

//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(callLeft) andImageName:@"top_navigation_menuicon" andImageNameHighlight:nil];
//    
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:nil andImageName:@"location" andImageNameHighlight:nil];
//    self.navigationController.navigationBar.barTintColor = ANColor(40, 40, 40, 0.3);
//    self.navigationController.navigationBar.hidden = YES;
//    // Do any additional setup after loading the view from its nib.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    ANAwesomeMenuHideOrShow
    
    ANAwesomeMenu *awm = [ANAwesomeMenu sharedAwesomeMenu];
    awm.delegate = self;
}

#pragma mark AwesomeMenuDelegate
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    switch (idx) {
        case 0:
            [self.sideMenuViewController presentLeftMenuViewController];
            //            [ANNotificationCenter postNotificationName:ANCallLeftNotification object:nil];
            break;
            
        case 1:
            [self.sideMenuViewController backToHomeViewController];
            //            [ANNotificationCenter postNotificationName:ANCallHomeNotification object:nil];
            break;
            
        case 2:
            [self.sideMenuViewController presentRightMenuViewController];
            //            [ANNotificationCenter postNotificationName:ANCallRightNotification object:nil];
            break;
            
            
        default:
            break;
    }
}


@end
