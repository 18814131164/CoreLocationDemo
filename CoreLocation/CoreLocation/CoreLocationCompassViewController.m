//
//  CoreLocationCompassViewController.m
//  CoreLocation
//
//  Created by 众网合一 on 16/7/19.
//  Copyright © 2016年 GdZwhy. All rights reserved.
//

#import "CoreLocationCompassViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface CoreLocationCompassViewController ()<CLLocationManagerDelegate>
/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *lM;
@property (nonatomic, strong) UIImageView *compassView;
@end

@implementation CoreLocationCompassViewController

- (CLLocationManager *)lM
{
    if (!_lM) {
        _lM = [[CLLocationManager alloc] init];
        _lM.delegate = self;
        
        // 每隔多少度更新一次
        _lM.headingFilter = 2;
        
    }
    return _lM;
}

- (UIImageView *)compassView
{
    if (!_compassView) {
        _compassView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_compasspointer"]];
        _compassView.frame = CGRectMake((self.view.frame.size.height -300) * 0.5, (self.view.frame.size.height -300) * 0.5, 300, 300);
    }
    return _compassView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 开始监听设备朝向
    [self.lM startUpdatingHeading];
}


#pragma mark - CLLocationManagerDelegate
/**
 *  获取到手机朝向时调用
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    /**
     *  CLHeading
     *  magneticHeading : 磁北角度
     *  trueHeading : 真北角度
     */
    
    NSLog(@"%f", newHeading.magneticHeading);
    
    CGFloat angle = newHeading.magneticHeading;
    
    // 把角度转弧度
    CGFloat angleR = angle / 180.0 * M_PI;
    
    // 旋转图片
    [UIView animateWithDuration:0.25 animations:^{
        self.compassView.transform = CGAffineTransformMakeRotation(-angleR);
    }];
    
    
}


@end
