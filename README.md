# CoreLocationDemo
关于iOS7、iOS8、iOS9CoreLocation定位的测试Demo
***
CoreLocation 属性方法简述


 ```
// 设置每隔多远调用以下定位方法一次:(单位:米)
// - (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations

_lm.distanceFilter = 100;
 ```
 
 ```
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
 ```
 
 ```
// 开始更新用户位置
// 默认只能在前台获取用户位置
// 勾选后台模式 location updates
 
[self.lm startUpdatingLocation];
 
// 停止更新

[manager stopUpdatingLocation];
 ```
 
 ***
 iOS8.0定位适配
 
 ```
         if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
        {
            
	
	 /** 使用下列请求授权方法需要在Info.plist中加入NSLocationWhenInUseUsageDescription键值，否则下列方法无效*/
            
            // 前台定位授权(默认情况下,不可以在后台获取位置, 勾选后台模式 location update, 但是 会出现蓝条)
            // [_lm requestWhenInUseAuthorization];
            
            
            

  /**使用下列请求授权方法需要在Info.plist中加入NSLocationAlwaysUsageDescription键值，否则下列方法无效*/
            
            // 前后台定位授权(请求永久授权)
            // +authorizationStatus != kCLAuthorizationStatusNotDetermined
            // 这个方法不会有效
            // 当前的授权状态为前台授权时,此方法也会有效
            
            [_lm requestAlwaysAuthorization];
            
        }
        
     /**如果不想做设备判断，可以用下列方法*/   
        
        //        if ([_lm respondsToSelector:@selector(requestAlwaysAuthorization)])
        //        {
        //            [_lm requestAlwaysAuthorization];
        //        }
 ```
 
 
  // 授权状态发生改变时调用
  
 ```

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

 ```
 ***
 iOS9.0定位适配
 
 ```
 // 允许后台获取用户位置（iOS9.0）
 if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
       // 一定要勾选后台模式 location updates
       _lm.allowsBackgroundLocationUpdates = YES;
 }
 
 ```
 
 ```
     /*
     extern const CLLocationAccuracy kCLLocationAccuracyBestForNavigation //最适合导航
     extern const CLLocationAccuracy kCLLocationAccuracyBest;//最好的
     extern const CLLocationAccuracy kCLLocationAccuracyNearestTenMeters;//附近10米
     extern const CLLocationAccuracy kCLLocationAccuracyHundredMeters;//100m
     extern const CLLocationAccuracy kCLLocationAccuracyKilometer;//1000m
     extern const CLLocationAccuracy kCLLocationAccuracyThreeKilometers;//3000m
     */
     
    // 在有效的超时时间内从远到近找到最好的定位进行返回
    [self.lm requestLocation];
 ```
 
***
指南针

```
// 每隔多少度更新一次

_lM.headingFilter = 2;

```

```
// 开始监听设备朝向

[self.lM startUpdatingHeading];

```

CLLocationManagerDelegate

```
// 获取到手机朝向时调用
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
```
***
区域监听

```
 
    // 多个区域监听
    
    CLLocationCoordinate2D center = {23.13, 124.56};
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:1000 identifier:@"广州"];
    // 开始进行区域监听
    [self.lm startMonitoringForRegion:region];
    
    //    CLLocationCoordinate2D center2 = {24.13, 111.46};
    //    CLCircularRegion *region2 = [[CLCircularRegion alloc] initWithCenter:center2 radius:1000 identifier:@"北京"];
    //
    //    [self.lm startMonitoringForRegion:region2];
    
    // 请求区域状态:每次请求回调用代理方法
    [self.lm requestStateForRegion:region];

```
CLLocationManagerDelegate

```

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


```

***
地理编码与反编码

```

- (CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}


```


```
// 地理编码
[self.geoC geocodeAddressString:@"保利中辰" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {

        /**
         *   CLPlacemark
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



// 反地理编码
 CLLocation *loc = [[CLLocation alloc] initWithLatitude:23.123 longitude:122.122];
 
[self.geoC reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {

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
            NSLog(@"cuowu");
        }
        
    }];

```