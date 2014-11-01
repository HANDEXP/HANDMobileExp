//
//  EXPLocationManager.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-21.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPLocationManager.h"
#import "EXPLocationAPI.h"

@interface EXPLocationManager ()<CLLocationManagerDelegate>
{
    NSArray *locationInfo;
    CLLocationManager *locManager;
    NSString * currentLatitude;
    NSString * currentLongitude;
    NSURL *currentUrl;
    NSString *city;
    NSString *province;
}
@end

@implementation EXPLocationManager

- (id)init
{
    self = [super init];
    
    if (self) {
        locManager = [[CLLocationManager alloc] init];
        locManager.delegate = self;
        locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        [locManager startUpdatingLocation];
        locManager.distanceFilter = 1000.0f;
        
        }
    
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    CLLocation *currentLocation = [locations lastObject];
    
    currentLatitude = [[NSString alloc]
                       initWithFormat:@"%g",
                       currentLocation.coordinate.latitude];
    currentLongitude = [[NSString alloc]
                        initWithFormat:@"%g",
                        currentLocation.coordinate.longitude];
    
    currentUrl = [self getUrlWithLatitude:currentLatitude Longitude:currentLongitude];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:currentUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    ///////////////
    if (received == nil) {
        city = @"";
        province = @"";
    }else{
        
        NSDictionary *locationInfo = [NSJSONSerialization  JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:Nil];
        
        NSDictionary *result = [locationInfo objectForKey:@"result"];
        
        NSDictionary *addressComponent = [result objectForKey:@"addressComponent"];
        
        city = [[NSString alloc]initWithFormat:@"%@",[addressComponent objectForKey:@"city"]];
        
        [EXPLocationAPI shareInstance].city = city;
        
        province = [[NSString alloc]initWithFormat:@"%@",[addressComponent objectForKey:@"province"]];
        [EXPLocationAPI shareInstance].province = province;
    //[self.locationManager stopUpdatingLocation];
    }
    [locManager stopUpdatingLocation];
    
    
}

- (NSURL *)getUrlWithLatitude:(NSString *)latitude Longitude:(NSString *)longitude
{
    NSString * str1 = @"http://api.map.baidu.com/geocoder/v2/?ak=7910194f48de7e5013c3bd2d3f977b1c&location=";
    NSString * str2 = @",";
    NSString * str3 = @"&output=json&pois=0";
    NSString * string = @"";
    string = [string stringByAppendingFormat:@"%@%@%@%@%@",str1,latitude,str2,longitude,str3];
    
    
    
    NSURL *url = [NSURL URLWithString:string];
    
    return url;
}

- (NSString *)getCity
{
    return city;
}

- (NSString *)getProvince
{
    return province;
}


@end
