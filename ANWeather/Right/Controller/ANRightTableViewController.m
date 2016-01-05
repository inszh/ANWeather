//
//  ANRightTableViewController.m
//  ANWeather
//
//  Created by a on 15/12/29.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
// 
#import "ANRightTableViewController.h"
#import "ANRightTableViewCell.h"
#import "ViewController.h"


#import "ANCitySearchController.h"

// 已选城市缓存路径
#define ANSelectedCityFilePath [ANDocumentPath stringByAppendingPathComponent:@"selectedCity.data"]

@interface ANRightTableViewController ()<ANRightTableViewCellDelegate>

@end

@implementation ANRightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化tableView
    [self setupTableView];
    
}



- (void)setupTableView
{
    self.tableView.frame = CGRectMake(0, (ANScreenHeight - 54 * 5) /2.0f, ANScreenWidth, 54*5);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    self.tableView.contentInset = UIEdgeInsetsMake(ANScreenHeight*0.5, 0, 0, 0);
//    self.tableView.contentSize = CGSizeMake(ANScreenWidth*0.1, ANScreenHeight);
    self.tableView.backgroundColor = [UIColor clearColor];

    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.selectedCitys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    ANRightTableViewCell *cell = [ANRightTableViewCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.tag = indexPath.row;
    cell.backgroundColor = [UIColor clearColor];
    
    if (0 == indexPath.row) {
        cell.delCityBtn.hidden = YES;
        cell.locIcon.image = [UIImage imageNamed:@"addcity"];
    } else if (1 == indexPath.row){
        cell.delCityBtn.hidden = YES;
        cell.locIcon.image = [UIImage imageNamed:@"city"];
    } else {
        cell.locIcon.image = [UIImage imageNamed:@"city"];
    }
    
    cell.cityName.text = self.selectedCitys[indexPath.row];
    
    return cell;
}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (0 == indexPath.row) {
        
        ANCitySearchController *search = [[ANCitySearchController alloc] init];
        [self presentViewController:search animated:YES completion:nil];
        [search returnCityNameBlock:^(NSString *cityName) {

            if(![self.selectedCitys containsObject:cityName]) { // 如果选择城市不存在
                
                // 1.把传回来的城市添加到已选城市列表
                [self.selectedCitys insertObject:cityName atIndex:2];
                
                // 2.刷新表格
                [self.tableView reloadData];
                
                // 3.缓存到本地
                [NSKeyedArchiver archiveRootObject:self.selectedCitys toFile:ANSelectedCityFilePath];
            }
        }];
    
    } else if (1 == indexPath.row){
        [ANNotificationCenter postNotificationName:ANGetLocationDidClickNotification object:nil];
        
    } else {
        // 发布关于城市被点击的通知
        [ANNotificationCenter postNotificationName:ANCityDidClickNotification object:nil userInfo:self.selectedCitys[indexPath.row]];
        // 回到首页
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] animated:YES];
        [self.sideMenuViewController hideMenuViewController];

    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark 懒加载
- (NSMutableArray *)selectedCitys
{
    if (_selectedCitys == nil) {
        
        // 1.从本地读取
        _selectedCitys = [NSKeyedUnarchiver unarchiveObjectWithFile:ANSelectedCityFilePath];
        
        // 2.如果读取出来为空
        if (_selectedCitys == nil) {
            _selectedCitys = [NSMutableArray array];
            [_selectedCitys addObjectsFromArray:@[@"添加", @"定位"]];
        }
        
    }

    return _selectedCitys;
}

#pragma mark ANRightTableViewCellDelegate
- (void)rightTableViewCellDidClickDelBtnAtCell:(ANRightTableViewCell *)cell
{
    
    [self showAlertWithBlock:^{
        [self.selectedCitys removeObjectAtIndex:cell.tag];
        
        // 缓存到本地
        [NSKeyedArchiver archiveRootObject:self.selectedCitys toFile:ANSelectedCityFilePath];
        
        [self.tableView reloadData];
    }];

}


/**
 *  弹出提醒设置定位功能
 */
- (void)showAlertWithBlock:(void(^)(void))doSth
{
    
    // 初始化alert控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除这个城市?"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    // cancel
    UIAlertAction  *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *action) {
                                                        
                                                    }];
    
    // ok
    UIAlertAction  *ok = [UIAlertAction actionWithTitle:@"确定"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    
                                                    doSth();
                                                }];
    
    // 添加动作
    [alert addAction:cancel];
    [alert addAction:ok];
    
    // present出alert
    [self presentViewController:alert animated:YES completion:nil];
    
    
}




@end
