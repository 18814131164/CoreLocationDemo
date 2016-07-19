//
//  CoreLocationiOS7ViewController.m
//  CoreLocation
//
//  Created by 众网合一 on 16/7/19.
//  Copyright © 2016年 GdZwhy. All rights reserved.
//

#import "CoreLocationiOS7ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface CoreLocationiOS7ViewController ()<CLLocationManagerDelegate>

@property (nonatomic , strong) CLLocationManager *lm;

@end

@implementation CoreLocationiOS7ViewController

#pragma mark - 懒加载
// 创建位置管理者
- (CLLocationManager *)lm
{
    if (!_lm) {
        _lm = [[CLLocationManager alloc]init];
        _lm.delegate = self;
        // 每隔多远调用定位方法一次:(单位:米)
        // - (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
        _lm.distanceFilter = 100;
        /*
            extern const CLLocationAccuracy kCLLocationAccuracyBestForNavigation //最适合导航
            extern const CLLocationAccuracy kCLLocationAccuracyBest;//最好的
            extern const CLLocationAccuracy kCLLocationAccuracyNearestTenMeters;//附近10米
            extern const CLLocationAccuracy kCLLocationAccuracyHundredMeters;//100m
            extern const CLLocationAccuracy kCLLocationAccuracyKilometer;//1000m
            extern const CLLocationAccuracy kCLLocationAccuracyThreeKilometers;//3000m
         */
        
        // 精确度越高，越耗电，定位时间越长
        _lm.desiredAccuracy = kCLLocationAccuracyBest;

    }
    return _lm;
}

#pragma mark - 开始定位

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 开始更新用户位置
    // 默认只能在前台获取用户位置
    // 勾选后台模式 location updates
    [self.lm startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

// 更新到位置之后调用：这个方法是不停调用的，所以要在该方法中做一些操作
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    // 拿到位置后，做一些业务逻辑操作
    // ...
    
    // 停止更新
    // [manager stopUpdatingLocation];
}

// 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    // ...
}


@end
