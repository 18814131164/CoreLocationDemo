//
//  CoreLocationAreaMonitorViewController.m
//  CoreLocation
//
//  Created by 众网合一 on 16/7/19.
//  Copyright © 2016年 GdZwhy. All rights reserved.
//

#import "CoreLocationAreaMonitorViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface CoreLocationAreaMonitorViewController ()<CLLocationManagerDelegate>

/**  位置管理者 */
@property (nonatomic, strong) CLLocationManager *lm;

@end

@implementation CoreLocationAreaMonitorViewController

- (CLLocationManager *)lm
{
    if (!_lm) {
        _lm = [[CLLocationManager alloc] init];
        _lm.delegate = self;
        
        if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
        {
            [_lm requestAlwaysAuthorization];
        }
        
    }
    return _lm;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    // 区域监听
    
    CLLocationCoordinate2D center = {21.13, 123.456};
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:1000 identifier:@"小码哥"];
    
    //    [self.lm startMonitoringForRegion:region];
    
    //    CLLocationCoordinate2D center2 = {21.13, 123.456};
    //    CLCircularRegion *region2 = [[CLCircularRegion alloc] initWithCenter:center2 radius:1000 identifier:@"小码哥2"];
    //
    //    [self.lm startMonitoringForRegion:region2];
    
    // 请求区域状态
    [self.lm requestStateForRegion:region];
    
}


#pragma mark - CLLocationManagerDelegate
// 进入区域
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"进入区域--%@", region.identifier);
}

// 离开区域
-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"离开区域--%@", region.identifier);
}


-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSLog(@"%zd", state);
    
    
}


@end
