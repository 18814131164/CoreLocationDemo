//
//  CoreLocationGeocoderViewController.m
//  CoreLocation
//
//  Created by 众网合一 on 16/7/19.
//  Copyright © 2016年 GdZwhy. All rights reserved.
//

#import "CoreLocationGeocoderViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface CoreLocationGeocoderViewController ()

/** 地理编码 */
@property (nonatomic, strong) CLGeocoder *geoC;

@end

@implementation CoreLocationGeocoderViewController

- (CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self geoCoder];
}

// 编码
- (void)geoCoder
{
    
    [self.geoC geocodeAddressString:@"保利中辰" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        /**
         *  CLPlacemark
         location : 位置对象
         addressDictionary : 地址字典
         name : 地址全称
         */
        if(error == nil)
        {
            NSLog(@"%@", placemarks);
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSLog(@"%@", obj.name);
                NSLog(@"%@", @(obj.location.coordinate.longitude).stringValue);
                NSLog(@"%@", @(obj.location.coordinate.latitude).stringValue);
                
            }];
        }else
        {
            NSLog(@"cuowu--%@", error.localizedDescription);
        }
        
    }];
    
}

// 反编码
- (void)reverseGeoCoder
{
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:23.123 longitude:122.22];
    [self.geoC reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error == nil)
        {
            NSLog(@"%@", placemarks);
            
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSLog(@"%@", obj.name);
                NSLog(@"%@", @(obj.location.coordinate.longitude).stringValue);
                NSLog(@"%@", @(obj.location.coordinate.latitude).stringValue);
                
            }];
        }
        else
        {
            NSLog(@"cuowu");
        }
        
    }];
    
}

@end
