//
//  ANRightTableViewController.h
//  ANWeather
//
//  Created by a on 15/12/29.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ANRightTableViewControllerDelegate <NSObject>

@optional
- (void)rightTableViewControllerClickGetLocation;

@end

 @interface ANRightTableViewController : UITableViewController
 
/**
 *  存放城市们的数组
 */
@property (strong, nonatomic)NSMutableArray *selectedCitys;

@property (weak, nonatomic)id<ANRightTableViewControllerDelegate> delegate;

@end
