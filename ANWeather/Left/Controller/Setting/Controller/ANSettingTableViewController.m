//
//  ANSettingTableViewController.m
//  ANWeather
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANSettingTableViewController.h"
#import "MBProgressHUD+MJ.h" 
#import "AwesomeMenu.h"
#define ANTabViewHeight 50

@interface ANSettingTableViewController ()

@property (copy, nonatomic)NSString *cache;
/**
 * 大小手模式
 */
@property (copy, nonatomic)NSString *bigSmallHandMode;
/**
 * 风力单位
 */
@property (copy, nonatomic)NSString *windScaleSpeedMode;
/**
 * 温度单位
 */
@property (copy, nonatomic)NSString *tmpMode;
/**
 *  摇一摇开关
 */
@property (weak, nonatomic)UISwitch *switchBtn;
/**
 *  底部按钮
 */
@property (weak, nonatomic)UIView *tabbarView;


@end

@implementation ANSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置tableView
    [self setupTableView];
  
    // 设置tabbar
    [self setupTabbarView];
}

-(void)setupTabbarView
{
    // 容器
    UIView *tabbarView = [[UIView alloc] init];
    tabbarView.frame = CGRectMake(0, ANScreenHeight - 64-ANTabViewHeight, ANScreenWidth, ANTabViewHeight);
   
    // 按钮
    UIButton *btn = [[UIButton alloc] init];
    btn.imageView.image = [UIImage imageNamed:@"back"];
    btn.frame = CGRectMake(0, 0, ANTabViewHeight, ANTabViewHeight);
    [btn addTarget:self.sideMenuViewController action:@selector(presentLeftMenuViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *homeBtn = [[UIButton alloc] init];
    homeBtn.frame = CGRectMake(ANTabViewHeight, 0, ANTabViewHeight, ANTabViewHeight);
    [btn addTarget:self.sideMenuViewController action:@selector(backToHomeViewController) forControlEvents:UIControlEventTouchUpInside];
    
    [tabbarView addSubview:btn];
    [tabbarView addSubview:homeBtn];
    
    tabbarView.backgroundColor = ANNavBarColor;
    [self.view addSubview:tabbarView];
    self.tabbarView = tabbarView;
    
}

 - (void)setupTableView
{
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = ANColor(217, 217, 223, 1.0);
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
      
    cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                
                cell.textLabel.text = @"温度单位";
                cell.detailTextLabel.text = self.tmpMode;
            } else if (indexPath.row == 1){
                
                cell.textLabel.text = @"风力单位";
                cell.detailTextLabel.text = self.windScaleSpeedMode;
            }
            
            
            cell.imageView.image = [UIImage imageNamed:@[@"blueArrow", @"blueArrow"][indexPath.row]];
            break;
            
        case 1:
            cell.textLabel.text = @"大手模式";
            cell.detailTextLabel.text = self.bigSmallHandMode;
            cell.imageView.image = [UIImage imageNamed:@"blueArrow"];
            break;
            
        case 2:
            cell.textLabel.text = @"清空缓存";
             cell.detailTextLabel.text = [self getCacheSize];
            cell.imageView.image = [UIImage imageNamed:@"blueArrow"];
            break;
            
        case 3:
            
            cell.textLabel.text = @"摇一摇分享";
            [self switchBtnAtCell:cell];
            cell.highlighted = NO;
            cell.imageView.image = [UIImage imageNamed:@"blueArrow"];
            break;
        default:
            break;
    }
    return cell;
    
}
/**
 *  创建switch
 *
 *  @param cell 放到哪个cell上
 */
- (void)switchBtnAtCell:(UITableViewCell *)cell
{
    UISwitch *switchBtn = [[UISwitch alloc] init];
    [ANSettingTool isShakeEnable] ? (switchBtn.on = YES) : (switchBtn.on = NO);
    switchBtn.centerY = cell.centerY;
    switchBtn.x = cell.width - switchBtn.width - 20;
    [cell.contentView addSubview:switchBtn];
    
    self.switchBtn = switchBtn;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    // 是摄氏度嘛
                    
                    if ([ANSettingTool isC]) {
                        self.tmpMode = @"°F";
                    } else {
                        self.tmpMode = @"°C";
                    }
                    
                    // 转为华氏并存到数据库
                    [ANSettingTool updateC:![ANSettingTool isC]];
                    break;
                    
                case 1:
                    
                    [ANSettingTool isWindScale] ? (self.windScaleSpeedMode = @"km/h") : (self.windScaleSpeedMode = @"风力等级");
                    
                    [ANSettingTool updateWindScale:![ANSettingTool isWindScale]];

                    break;
                    
                default:
                    break;
            }
            
            break;
            
        case 1:
            
            if ([ANSettingTool isBigHand]) {
                self.bigSmallHandMode = @"小手模式";
             } else {
                self.bigSmallHandMode = @"大手模式";
              }
            
            
            [ANSettingTool updateBigHand:![ANSettingTool isBigHand]];

             break;
            
        case 2:
            // 清空缓存
            
            [MBProgressHUD showMessage:@"正在清理..." toView:self.view];
            [self myClearCacheAction];
            self.cache = [self getCacheSize];
             break;
            
        case 3:
            // 摇一摇分享
            [ANSettingTool isShakeEnable] ? ([self.switchBtn setOn:NO animated:YES]) : ([self.switchBtn setOn:YES animated:YES]);
            [ANSettingTool updateShakeEnable:![ANSettingTool isShakeEnable]];
            
            break;
   
            
        default:
            break;
            
    }
    [self.tableView reloadData];
}



#pragma mark - 计算缓存大小
- (NSString *)getCacheSize
{
   //定义变量存储总的缓存大小
   long long sumSize = 0;

   //01.获取当前图片缓存路径
   NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];

    //02.创建文件管理对象
    NSFileManager *filemanager = [NSFileManager defaultManager];

        //获取当前缓存路径下的所有子路径
    NSArray *subPaths = [filemanager subpathsOfDirectoryAtPath:cacheFilePath error:nil];
   
        //遍历所有子文件
    for (NSString *subPath in subPaths) {
             //1）.拼接完整路径
         NSString *filePath = [cacheFilePath stringByAppendingFormat:@"/%@",subPath];
             //2）.计算文件的大小
         long long fileSize = [[filemanager attributesOfItemAtPath:filePath error:nil]fileSize];
             //3）.加载到文件的大小
         sumSize += fileSize;
     }
    
    NSString *text = nil;
    
    if (sumSize <1024) {
        text = @"";
    } else if (sumSize>=1024 && sumSize <1024*1024) {
        text = [NSString stringWithFormat:@"%lldKB", sumSize / 1024];
    } else {
        CGFloat floatSize = sumSize/1024/1024;
        text = [NSString stringWithFormat:@"%.2fM", floatSize];
    }
    
    return text;
    
}


-(void)myClearCacheAction{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%lu",(unsigned long)[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                               
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    
    
}


-(void)clearCacheSuccess
{
    
    [MBProgressHUD hideHUD];
    [MBProgressHUD showSuccess:@"清理成功"];
    
}

- (NSString *)windScaleSpeedMode
{
    if (!_windScaleSpeedMode) {
        _windScaleSpeedMode = [ANSettingTool isWindScale] ? @"风力等级" : @"km/h";
    }
    return _windScaleSpeedMode;
}

- (NSString *)tmpMode
{
    if (!_tmpMode) {
        _tmpMode = [ANSettingTool isC] ? @"°C" : @"°F";
    }
    return _tmpMode;
}

- (NSString *)bigSmallHandMode
{
    if (!_bigSmallHandMode) {
        _bigSmallHandMode = [ANSettingTool isBigHand] ? @"大手模式" : @"小手模式";
    }
    return _bigSmallHandMode;
}












@end