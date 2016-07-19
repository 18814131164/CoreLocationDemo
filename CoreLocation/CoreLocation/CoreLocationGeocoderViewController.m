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

- (IBAction)geoCoder {
    
    
//    NSString *addr  = self.addressTV.text;
//    
//    if ([addr length] == 0) {
//        return;
//    }
    
//    [self.geoC geocodeAddressString:addr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        /**
//         *  CLPlacemark
//         location : 位置对象
//         addressDictionary : 地址字典
//         name : 地址全称
//         */
//        if(error == nil)
//        {
//            NSLog(@"%@", placemarks);
//            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSLog(@"%@", obj.name);
//                self.addressTV.text = obj.name;
//                self.laTF.text = @(obj.location.coordinate.latitude).stringValue;
//                self.longTF.text = @(obj.location.coordinate.longitude).stringValue;
//            }];
//        }else
//        {
//            NSLog(@"cuowu--%@", error.localizedDescription);
//        }
//        
//    }];
    
}
- (IBAction)reverseGeoCoder {
    
    
//    double lati = [self.laTF.text doubleValue];
//    double longi = [self.longTF.text doubleValue];
    
    // TODO: 容错
    
//    CLLocation *loc = [[CLLocation alloc] initWithLatitude:lati longitude:longi];
//    [self.geoC reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if(error == nil)
//        {
//            NSLog(@"%@", placemarks);
//            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSLog(@"%@", obj.name);
////                self.addressTV.text = obj.name;
////                self.laTF.text = @(obj.location.coordinate.latitude).stringValue;
////                self.longTF.text = @(obj.location.coordinate.longitude).stringValue;
//            }];
//        }else
//        {
//            NSLog(@"cuowu");
//        }
//        
//    }];
    
}


@end
