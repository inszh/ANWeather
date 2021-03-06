//
//  ANWindSpeedItemView.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANWindSpeedItemView.h"
#import "ANWindmill.h"
#import "ArknowM.h"
@interface ANWindSpeedItemView ()
/**
 *  风速
 */
@property (weak, nonatomic) IBOutlet ANWindmill *windmill;
/**
 *  风向
 */
@property (weak, nonatomic) IBOutlet UILabel *windDirLabel;

@end
@implementation ANWindSpeedItemView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    ANWindmill *windmill = [ANWindmill view];
    windmill.backgroundColor = [UIColor clearColor];
    windmill.frame = self.windmill.bounds;
    [self addSubview:windmill];
    self.windmill = windmill;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.cornerRadius = ANCornerRadius;
    gradient.shadowColor = [UIColor blackColor].CGColor;
    gradient.shadowOffset = CGSizeMake(1.5, 1.5);
    gradient.shadowOpacity = 0.5;


    gradient.frame = rect;
    gradient.colors = [NSArray arrayWithObjects:(id)ANColor(255, 255, 255, 0.1).CGColor,
                       (id)ANItemBackgroundColor, nil];
    [self.layer insertSublayer:gradient atIndex:0];
    
}

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANWindSpeedItemView" owner:nil options:0 ] lastObject];
}

 
-(void)setNowm:(ArknowM *)nowm
{
    _nowm=nowm;
    // 风速
    self.windmill.nowm = nowm;
    // 风向 风力
    NSString *dir = nowm.wind_dir;
     if ([dir isEqualToString:@"无持续风向"]) {
        dir = @"";
    } else {
        dir = nowm.wind_dir;
    }

    
    NSString *sc = nowm.wind_sc;
    NSString *spd = nowm.wind_spd;
    self.windDirLabel.font = ANLightFontSize17;
    
    // 如果是微风 不显示级字
    NSString *ji = nil;
    if ([sc isEqualToString:@"微风"]) {
        ji = @"";
    } else {
        ji = @"级";
    }
    
    if ([ANSettingTool isWindScale]) {
        self.windDirLabel.textAlignment = NSTextAlignmentLeft;

        // attrs
        NSString *dirSpeedStr = [NSString stringWithFormat:@" %@ %@%@", dir, sc, ji];
        NSMutableAttributedString *dirSpeedAttr = [[NSMutableAttributedString alloc] initWithString:dirSpeedStr];
        // 修改风向字体大小
        [dirSpeedAttr addAttribute:NSFontAttributeName value:ANLightFontSize12 range:NSMakeRange(1, dir.length)];
        // 修改风速字体大小
        [dirSpeedAttr addAttribute:NSFontAttributeName value:ANLightFontSize17 range:NSMakeRange(1+dir.length, spd.length)];

        self.windDirLabel.attributedText = dirSpeedAttr;
        
    } else {
        
        self.windDirLabel.textAlignment = NSTextAlignmentCenter;

        // 风速风向
        NSString *dirSpeedStr = [NSString stringWithFormat:@"%@ %@ kmh", dir, spd];
        NSMutableAttributedString *dirSpeedAttr = [[NSMutableAttributedString alloc] initWithString:dirSpeedStr];
        // 修改风向字体大小
        [dirSpeedAttr addAttribute:NSFontAttributeName value:ANLightFontSize12 range:NSMakeRange(0, dir.length)];
        // 修改风速字体大小
        [dirSpeedAttr addAttribute:NSFontAttributeName value:ANLightFontSize17 range:NSMakeRange(dir.length, spd.length)];
        // 修改级数字体大小
        [dirSpeedAttr addAttribute:NSFontAttributeName value:ANLightFontSize12 range:NSMakeRange(dirSpeedStr.length-3 , 3)];
        
        self.windDirLabel.attributedText = dirSpeedAttr;// [NSString stringWithFormat:@"%@%@kmh",weatherData.now.wind.dir, weatherData.now.wind.spd];
    }
    
}

//
//- (NSAttributedString *)attrWithDir:(NSString *)dir scSpd:(NSString *)scSpd
//{
//    // attrs
//    NSString *dirSpeedStr = [NSString stringWithFormat:@" %@ %@级", dir, scSpd];
//    NSMutableAttributedString *dirSpeedAttr = [[NSMutableAttributedString alloc] initWithString:dirSpeedStr];
//    // 修改风向字体大小
//    [dirSpeedAttr addAttribute:NSFontAttributeName value:ANLightFontSize12 range:NSMakeRange(2, dir.length)];
//    // 修改风速字体大小
//    [dirSpeedAttr addAttribute:NSFontAttributeName value:ANLightFontSize17 range:NSMakeRange(2+dir.length, spd.length)];
//    
//    return dirSpeedStr;
//}


@end
