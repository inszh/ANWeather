//
//  ANHumidityItemView.m
//  ANWeather
//
//  Created by a on 16/1/19.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANHumidityItemView.h"
#import "ArknowM.h"
@interface ANHumidityItemView()
/**
 *  湿度
 */
@property (weak, nonatomic) IBOutlet UILabel *humLabel;

@end

@implementation ANHumidityItemView


+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANHumidityItemView" owner:nil options:0 ] lastObject];
    
}


-(void)setNowm:(ArknowM *)nowm
{
    _nowm = nowm;
    // 设置湿度
    
    NSString *hum = [NSString stringWithFormat:@"%@%%", nowm.hum];
    NSMutableAttributedString *humAttr = [[NSMutableAttributedString alloc] initWithString:hum];
    [humAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(hum.length-1, 1)];
    [humAttr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(hum.length-1, 1)];
    self.humLabel.attributedText = humAttr;
    
    
}

@end
