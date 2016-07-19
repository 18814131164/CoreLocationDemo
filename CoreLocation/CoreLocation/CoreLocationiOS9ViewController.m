//
//  CoreLocationiOS9ViewController.m
//  CoreLocation
//
//  Created by 众网合一 on 16/7/19.
//  Copyright © 2016年 GdZwhy. All rights reserved.
//

#import "CoreLocationiOS9ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface CoreLocationiOS9ViewController ()<CLLocationManagerDelegate>
{
    CLLocation *_oldLocation;
}
@property (nonatomic , strong) CLLocationManager *lm;

@end

@implementation CoreLocationiOS9ViewController

- (CLLocationManager *)lm
{
    if (!_lm) {
        //  创建位置管理者
        _lm = [[CLLocationManager alloc]init];
        _lm.delegate = self;
        
        // 每隔多远调用定位方法一次:米
        _lm.distanceFilter = 100;
        
        
        // 精确度越高，越耗电，定位时间越长
        _lm.desiredAccuracy = kCLLocationAccuracyBest;
        
        
  
        /***-- iOS8.0 + 定位适配 --**/
        // 需要主动去请求权限
        // iOS8.0以下的会报错没有该方法
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            
            // 前后台定位授权
            // When +authorizationStatus != kCLAuthorizationStatusNotDetermined
            // 这个方法不会有效
            // 当前的授权状态为前台授权时，此方法也会有效
            //            [_lm requestAlwaysAuthorization];
            
            
            
            // 前台定位授权（默认情况下不可以在后台获取位置，勾选后台模式 location update,但是，会出现蓝条）
            [_lm requestWhenInUseAuthorization];
        }
        
        // 允许后台获取用户位置（iOS9.0）
        if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
            // 一定要勾选后台模式 location updates
            _lm.allowsBackgroundLocationUpdates = YES;
        }
        
        
        //        if ([_lm respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        //            [_lm requestAlwaysAuthorization];
        //        }
        
    }
    return _lm;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //    CLLocation *l1 = [[CLLocation alloc]initWithLatitude:21.123 longitude:123.456];
    //    CLLocation *l2 = [[CLLocation alloc]initWithLatitude:22.123 longitude:123.456];
    //    // 计算两个经纬度间的距离：1度大约110km
    //    CLLocationDistance distance = [l1 distanceFromLocation:l2];
    //    NSLog(@"%f",distance);
    
    // 开始更新用户位置
    // 默认只能在前台获取用户位置
    // 勾选后台模式 location updates
    [self.lm startUpdatingLocation];
    
 
    // 在有效的超时时间内从远到近找到最好的定位进行返回
    // [self.lm requestLocation];
}

#pragma mark - CLLocationManagerDelegate

// 更新到位置之后调用：这个方法是不停掉用的，所以要在该方法中做一些操作
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    NSLog(@"定位到了 - locations = %@",locations);
    /**
     * CLLocation 详解
     * coordinate: 经纬度坐标
     * altitude: 海拔
     * course:航向
     * speed：速度
     */
    CLLocation *location = [locations lastObject];
    
    /**
     *  场景演示:打印当前用户的行走方向,偏离角度以及对应的行走距离,
     例如:”北偏东 30度  方向,移动了8米”
     */
    //1.获取方向偏向
    NSString *angleStr = nil;
    
    NSInteger direction = (int)location.course / 90;
    
    switch (direction) {
        case 0://
            angleStr = @"北偏东";
            break;
        case 1:
            angleStr = @"东偏南";
            break;
        case 2:
            angleStr = @"南偏西";
            break;
        case 3:
            angleStr = @"西偏北";
            break;
        default:
            angleStr = @"跑沟里去了!!";
            break;
    }
    //2.偏向角度
    NSInteger angle = 0;
    angle = (int)location.course % 90;
    
    // 代表正方向
    if (angle == 0) {
        NSRange range = NSMakeRange(0, 1);
        angleStr = [NSString stringWithFormat:@"正%@",[angleStr substringWithRange:range]];
    }
    
    
    //3.移动了多少米
    double distance = 0;
    if (_oldLocation) {
        distance = [location distanceFromLocation:_oldLocation];
    }
    _oldLocation = location;
    //4.拼串打印
    NSString *noticeStr = [NSString stringWithFormat:@"%@%zd方向,移动了%f米",angleStr,angle,distance];
    
    NSLog(@"noticeStr = %@",noticeStr);
    
    // 拿到位置，做一些业务逻辑操作
    
    
    // 停止更新
    // [manager stopUpdatingLocation];
    
    
}

// 授权状态发生改变时调用
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    switch (status) {
            // 用户还未决定
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定");
            break;
        }
            // 访问受限
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

// 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
   //...
}
@end
