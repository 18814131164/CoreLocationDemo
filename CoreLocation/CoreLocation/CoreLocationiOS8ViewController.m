//
//  CoreLocationiOS8ViewController.m
//  CoreLocation
//
//  Created by 众网合一 on 16/7/19.
//  Copyright © 2016年 GdZwhy. All rights reserved.
//

#import "CoreLocationiOS8ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface CoreLocationiOS8ViewController ()<CLLocationManagerDelegate>

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *lm;

@end

@implementation CoreLocationiOS8ViewController

- (CLLocationManager *)lm
{
    if (!_lm) {
        // 创建位置管理者
        _lm = [[CLLocationManager alloc] init];
        _lm.delegate = self;
        
        // 每隔多米定位一次
        // _lm.distanceFilter = 100;
        
        /**
         kCLLocationAccuracyBestForNavigation // 最适合导航
         kCLLocationAccuracyBest; // 最好的
         kCLLocationAccuracyNearestTenMeters; // 10m
         kCLLocationAccuracyHundredMeters; // 100m
         kCLLocationAccuracyKilometer; // 1000m
         kCLLocationAccuracyThreeKilometers; // 3000m
         */
        // 精确度越高, 越耗电, 定位时间越长
        _lm.desiredAccuracy = kCLLocationAccuracyBest;
        
        
        /** -------iOS8.0+定位适配-------- */
        
        if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
        {
            
//            *      If the NSLocationWhenInUseUsageDescription key is not specified in your
//            *      Info.plist, this method will do nothing, as your app will be assumed not
//            *      to support WhenInUse authorization.
            
            // 前台定位授权(默认情况下,不可以在后台获取位置, 勾选后台模式 location update, 但是 会出现蓝条)
            // [_lm requestWhenInUseAuthorization];
            
            
            
            
//            *      If the NSLocationAlwaysUsageDescription key is not specified in your
//            *      Info.plist, this method will do nothing, as your app will be assumed not
//            *      to support Always authorization.
            
            
            // 前后台定位授权(请求永久授权)
            // +authorizationStatus != kCLAuthorizationStatusNotDetermined
            // 这个方法不会有效
            // 当前的授权状态为前台授权时,此方法也会有效
            [_lm requestAlwaysAuthorization];
            
        }
        
        //        if ([_lm respondsToSelector:@selector(requestAlwaysAuthorization)])
        //        {
        //            [_lm requestAlwaysAuthorization];
        //        }
        
    }
    return _lm;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 2. 使用位置管理者,开始更新用户位置
    // 默认只能在前台获取用户位置,
    // 勾选后台模式 location updates
    [self.lm startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
// 更新到位置之后调用
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"定位到了");
    
    // 拿到位置,做一些业务逻辑操作
    
    // 停止更新
    //    [manager stopUpdatingLocation];
}

// 授权状态发生改变时调用
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
            // 用户还未决定
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定");
            break;
        }
            // 问受限
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
            // 定位关闭时和对此APP授权为never时调用
        case kCLAuthorizationStatusDenied:
        {
            // 定位是否可用（是否支持定位或者定位是否开启）
            if([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"定位开启，但被拒");
            }else
            {
                NSLog(@"定位关闭，不可用");
            }
            //            NSLog(@"被拒");
            break;
        }
            // 获取前后台定位授权
        case kCLAuthorizationStatusAuthorizedAlways:
            //        case kCLAuthorizationStatusAuthorized: // 失效，不建议使用
        {
            NSLog(@"获取前后台定位授权");
            break;
        }
            // 获得前台定位授权
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台定位授权");
            break;
        }
        default:
            break;
    }
    
}

@end
