//
//  ANOffLineTool.h
//  大安微博
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANOffLineTool : NSObject
/**
 *  把返回的json存到本地
 */
+ (void)saveWeathersDictWithJson:(NSDictionary *)weathersDict;
/**
 * 根据城市名去沙盒中加载缓存
 */
+ (NSDictionary *)weathersWithCity:(NSString *)city;

+ (NSString *)getLastCity;
@end
